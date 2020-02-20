class RouteTable < BaseModel
  include Singleton

  attr_accessor :table

  def initialize
    @table = []
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

  def as_update
    # TODO!!
    RouteTableSerializer.new(self)
      .as_json[:routes]
      .each{ |r| r.delete(:metric) }
      .each{ |r| r.delete(:aspath) }
  end

  def as_sendable
    { 
      :routes =>
        RouteTableSerializer.new(self)
          .as_json[:routes]
          .each{ |r| r.delete :via },
      :asn => 99,
    }
  end
end
