# frozen_string_literal: true

class StatusSetterJob < ActiveJob::Base
  queue_as :status_setter_queue

  def perform
    Rails.logger.fatal '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!        STATUS SETTER JOB STARTED ' + Time.now.to_s
    auctions =  Auction.includes(:owner).active.where('end_time < ?', Time.now.utc)
    Rails.logger.fatal '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!        STATUS SETTER AUCTIONS SIZE ' + auctions.size.to_s

    auctions.each do |auction|
      auction.update_attribute(:status, :finished)

      UserMailer.auction_finished_owner_email(auction.owner.email || auction.email, auction.id).deliver_later

      auction.bidders.each do |bidder|
        UserMailer.auction_finished_bidder_email(bidder.id, auction.id).deliver_later
      end
    end
  end
end
