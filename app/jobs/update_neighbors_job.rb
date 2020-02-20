class UpdateNeighborsJob < ApplicationJob
  queue_as :default

  def perform(**args)
    NeighborList.each_neighbor do |n|
      n.send_update args[:table]
    end
  end
end
