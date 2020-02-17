require 'netaddr'

class Route < BaseModel
  attr_accessor :to, :via, :metric

  def initialize(**params)
    return :error unless params[:to] && params[:via]
    @to = params[:to]
    @via = params[:via]
    @metric = params[:metric] || 10
  end

  def include?(addr)
    to.contains addr
  end

  def ==(other)
    # routes are equal if their (to, via) tuple is the same
    # metrics are not considered to prevent reinserting the same route
    # from a different originator
    #
    # Also, this is actually what you have to do to compare NetAddr::IP*s
    # This makes me very sad.
    to.cmp(other.to) == 0 and via.cmp(other.via) == 0
  end

  def eql?(other)
    self == other
  end
end
