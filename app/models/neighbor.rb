require 'netaddr'

class Neighbor < BaseModel
  attr_reader :ip

  def initialize(**params)
    @ip = params[:ip]
  end
end
