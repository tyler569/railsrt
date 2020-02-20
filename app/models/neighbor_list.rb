class NeighborList < BaseModel
  include Singleton

  attr_accessor :list
  alias :neighbors :list

  def initialize
    @list = []
  end

  def each_neighbor(&block)
    list.each do |n|
      yield n
    end
  end

  def <<(neighbor)
    list << neighbor
  end

  def self.each_neighbor(&block)
    instance.each_neighbor(&block)
  end
end
