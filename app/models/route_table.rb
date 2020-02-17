require 'netaddr'

class RouteTable < BaseModel
  include Singleton

  attr_accessor :table

  def initialize
    @table = [
      Route.new({
        :to => NetAddr::IPv6Net.parse("2001::/8"),
        :via => NetAddr::IPv6.parse("2002::100"),
        :metric => 10,
      }),
      Route.new({
        :to => NetAddr::IPv6Net.parse("2001::/9"),
        :via => NetAddr::IPv6.parse("2002::102"),
        :metric => 10,
      }),
      Route.new({
        :to => NetAddr::IPv6Net.parse("2001::/8"),
        :via => NetAddr::IPv6.parse("2002::104"),
        :metric => 100,
      }),
      Route.new({
        :to => NetAddr::IPv6Net.parse("2001::/9"),
        :via => NetAddr::IPv6.parse("2002::106"),
        :metric => 100,
      })
    ]
  end

  def routes
    table
  end

  def matches(addr)
    table.filter{ |r| r.include? addr rescue false }
  end

  def bestmatch(addr)
    ms = matches(addr)

    # The best route match for a given destination
    # 1. matches that destination
    # 2. has the longest possible prefix of the remaining
    # 3. has the lowest possible metrix of the remaining

    ms.group_by{ |r| r.to.netmask.prefix_len }
      .max.last
      .min_by{ |r| r.metric }
  end
end
