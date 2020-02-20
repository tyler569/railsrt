require 'json'

class RoutesController < ApplicationController
  before_action :set_table
  before_action :set_ip, only: [:to, :to_all, :del]

  def all
    render json: @table
  end

  def to
    render json: @table.bestmatch(@ip)
  end

  def to_all
    render json: @table.matches(@ip)
  end

  def post
    body = JSON.parse(request.body.read())
    source = IPAddr.new request.ip
    source_as = body['asn']
    did_change = false

    if Config.local_asn == -1
      render json: {:error => "Not configured"}, :status => 503
    end

    body['routes'].each do |r|
      next if r['aspath'].include? Config.local_asn

      route = Route.new({
        to: IPAddr.new(r['to']),
        metric: r['metric'] + 1,
        via: source,
        aspath: [source_as] + r['aspath'],
      })
      next if @table.include? route

      @table << route
      did_change = true
    end

    if did_change
      ApplyRouteChangesJob.perform_later table: @table.as_update
      UpdateNeighborsJob.perform_later table: @table.as_sendable
    end
    render json: @table
  end

  def reset
    @table.table = []
    render json: @table
  end

  def del
    matches = @table.matches @ip
    @table.table.delete_if{ |r| matches.include? r }
    render json: @table
  end

  private

  def set_table
    @table = RouteTable.instance
  end

  def set_ip
    @ip = IPAddr.new params[:dest]
  end
end
