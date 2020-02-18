class NeighborList < BaseModel
  include Singleton

  attr_accessor :list
  alias :neighbors :list

  def initialize
    @list = [
      # Dummy dev data
      Neighbor.new({
        ip: IPAddr.new "5::2"
      }),
    ]
  end
end
