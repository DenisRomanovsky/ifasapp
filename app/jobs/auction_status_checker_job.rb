# frozen_string_literal: true

# Check the  auctions and trigger finalize jobs when required.
class AuctionStatusCheckerJob < ActiveJob::Base
  queue_as :status_checker_queue

  def perform(*_args)
    Rails.logger.fatal 'STATUS SETTER JOB STARTED ' + Time.now.to_s
    Auction
      .active
      .where('end_time < ?', Time.now.utc).each { |auction| AuctionFinalizerJob.perform_later(auction.id) }
  end
end
