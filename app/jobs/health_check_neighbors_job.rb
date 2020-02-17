class HealthCheckNeighborsJob < ApplicationJob
  queue_as :default

  after_perform do |job|
    # test neighbor connectivity repeatedly
    self.class.set(:wait => 5.seconds).perform_later(job.arguments.first))
  end

  def perform(*args)
    # Do something later
  end
end
