class AuctionStatusCheckerJob < ActiveJob::Base
  queue_as :status_checker_queue

  def perform(*args)
    Rails.logger.fatal 'STATUS SETTER JOB STARTED ' + Time.now.to_s
    auctions =  Auction.active.where('end_time < ?', Time.now.utc)

    Rails.logger.fatal 'STATUS SETTER - AUCTIONS LIST: ' + auctions.size.to_s

    auctions.each do |auction|
      AuctionFinalizerJob.perform_later(auction.id)
    end
    Rails.logger.fatal 'STATUS SETTER JOB FINISHED ' + Time.now.to_s
  end
end
