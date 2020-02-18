require 'ip_route'

class ApplyRouteChangesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "performing apply_route_chnges_job"
    p args
    #IpRoute.update_with_table(args[:table])
  end
end
