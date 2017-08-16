# frozen_string_literal: true

class AuctionFinalizerJob < ActiveJob::Base
  queue_as :auction_finalizers_queue

  def perform(auction_id)
    auction = Auction.includes(:owner).find(auction_id)
    auction.finished!

    owner_email = auction.owner.try(:email) || auction.user_email
    UserMailer.auction_finished_owner_email(owner_email, auction.id).deliver_later if owner_email.present?

    auction.bidders.each do |bidder|
      UserMailer.auction_finished_bidder_email(bidder.id, auction.id).deliver_later
    end
  end
end
