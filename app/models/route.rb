class Route < BaseModel
  attr_accessor :to, :via, :metric, :aspath

  def initialize(**params)
    return :error unless params[:to] && params[:via]
    @to = params[:to]
    @via = params[:via]
    @aspath = params[:aspath] || []
    @metric = params[:metric] || 10
  end

  def include?(addr)
    to.include? addr
  end

  def ==(other)
    # routes are equal if their (to, via) tuple is the same
    # metrics are not considered to prevent reinserting the same route
    # from a different originator

    to == other.to and via == other.via
  end

  def eql?(other)
    self == other
  end
end
