class NeighborList < BaseModel
  include Singleton

  attr_accessor :list
  alias :neighbors :list

  def initialize
    @list = [
      # Dummy dev data
      Neighbor.new({
        ip: IPAddr.new("::1")
      }),
    ]
  end

  def each_neighbor(&block)
    list.each do |n|
      yield n
    end
  end
end
