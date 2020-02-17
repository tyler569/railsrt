class NeighborsController < ApplicationController
  before_action :set_neighbors

  def neighbors
    render json: @neighbors
  end

  private

  def set_neighbors
    @neighbors = NeighborList.instance
  end
end
