# frozen_string_literal: true

class StatusSetterJob < ActiveJob::Base
  queue_as :default

  def perform
    Rails.logger.fatal '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
    Rails.logger.fatal 'JOB STARTED ' + Time.now.to_s
    Rails.logger.fatal '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
    Auction.includes(:owner).active.where('end_time < ?', Time.now.utc).each do |auction|
      auction.update_attribute(:status, :finished)

      UserMailer.auction_finished_owner_email(auction.owner.email || auction.email, auction.id).deliver_later

      auction.bidders.each do |bidder|
        UserMailer.auction_finished_bidder_email(bidder.id, auction.id).deliver_later
      end
    end
  end
end
