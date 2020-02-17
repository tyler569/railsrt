require 'netaddr'

class RoutesController < ApplicationController
  before_action :set_table
  before_action :set_ip, only: [:to, :to_all]

  def all
    render json: @table
  end

  def to
    render json: @table.bestmatch(@ip)
  end

  def to_all
    render json: @table.matches(@ip)
  end

  private

  def set_table
    @table = RouteTable.instance
  end

  def set_ip
    begin
      @ip = NetAddr::IPv6.parse params[:dest]
    rescue NetAddr::ValidationError
      @ip = NetAddr::IPv4.parse params[:dest]
    end
  end
end
