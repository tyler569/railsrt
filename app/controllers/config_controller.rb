class ConfigController < ApplicationController
  before_action :set_config

  def show
    render json: {:local_asn => @config.local_asn}
  end

  def update
    j = JSON.parse request.body.read()

    neighbors = NeighborList.instance
    route_table = RouteTable.instance

    @config.local_asn = j['local_asn']

    j['routes'].each do |h|
      r = Route.new({
        :to => IPAddr.new(h['to']),
        :via => IPAddr.new(h['via']),
        :metric => 0,
        :aspath => [],
      })
      route_table << r
    end

    j['neighbors'].each do |a|
      n = Neighbor.new({
        :ip => IPAddr.new(a)
      })
      neighbors << n
    end

    ApplyRouteChangesJob.perform_later :table => route_table.as_hash
    UpdateNeighborsJob.perform_later :table => route_table.as_sendable

    render json: {:good => 1}
  end

  private

  def set_config
    @config = Config.instance
  end
end
