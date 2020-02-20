require 'ip_route'

class ApplyRouteChangesJob < ApplicationJob
  queue_as :default

  def perform(**args)
    IpRoute.update_with_table(args[:table])
  end
end
