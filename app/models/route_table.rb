class RouteTable < BaseModel
  include Singleton

  attr_accessor :table

  def initialize
    @table = [
      # Dummy dev data
      Route.new({
        :to => IPAddr.new("2001::/8"),
        :via => IPAddr.new("2002::100"),
        :metric => 10,
      }),
      Route.new({
        :to => IPAddr.new("2001::/9"),
        :via => IPAddr.new("2002::102"),
        :metric => 10,
      }),
      Route.new({
        :to => IPAddr.new("2001::/8"),
        :via => IPAddr.new("2002::104"),
        :metric => 100,
      }),
      Route.new({
        :to => IPAddr.new("2001::/9"),
        :via => IPAddr.new("2002::106"),
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

    ms.group_by{ |r| r.to.prefix }
      .max.last
      .min_by{ |r| r.metric } rescue nil
  end

  def bestroutes
    table.group_by{ |r| r.to }
         .map{ |k, v| v.min_by{ |c| c.metric } }
  end

  def insert(route)
    return if route.metric > 20
    @table << route unless table.include? route
  end

  def include?(route)
    table.include? route
  end

  def <<(route)
    table << route
  end

  def as_hash
    RouteTableSerializer.new(self).as_json[:routes]
  end
end
