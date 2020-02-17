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
end
