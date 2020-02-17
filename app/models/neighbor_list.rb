require 'netaddr'

class NeighborList < BaseModel
  include Singleton

  attr_accessor :list
  alias :neighbors :list

  def initialize
    @list = [
      # Dummy dev data
      Neighbor.new({
        ip: NetAddr::IPv6.parse("5::2"),
      }),
    ]
  end
end
