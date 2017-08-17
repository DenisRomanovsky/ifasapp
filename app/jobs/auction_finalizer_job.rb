# frozen_string_literal: true

# Finalize Auction and send emails to owner and bidders.
class AuctionFinalizerJob < ApplicationJob
  queue_as :auction_finalizers_queue

  def perform(auction_id)
    auction = Auction.includes(:owner).find(auction_id)
    auction.finished!

    sent_owner_email(auction)
    sent_bidder_emails(auction)
  end

  private

  def sent_bidder_emails(auction)
    auction.bidders.each do |bidder|
      UserMailer.auction_finished_bidder_email(bidder.id, auction.id).deliver_later
    end
  end

  def sent_owner_email(auction)
    owner_email = auction.owner.try(:email) || auction.user_email
    UserMailer.auction_finished_owner_email(owner_email, auction.id).deliver_later if owner_email.present?
  end
end
