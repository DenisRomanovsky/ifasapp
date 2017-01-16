class AuctionEndEmailJob < ActiveJob::Base
  queue_as :urgent

  def perform(*args)
    # Do something later
    AuctionEndEmailJob.set()
  end
end
