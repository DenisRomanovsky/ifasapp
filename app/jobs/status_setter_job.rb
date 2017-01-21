class StatusSetterJob < ActiveJob::Base
  queue_as :default

  def perform
    puts 'JOB STARTED ' + Time.now.to_s
    Auction.includes(:bidders, :owner).active.where('end_time < ?', Time.now.utc).each do |auction|
      auction.update_attribute(:status, :finished)

      UserMailer.auction_finished_owner_email(auction.owner, auction.id).deliver_later

      auction.bidders.each do |bidder|
        UserMailer.auction_finished_bidder_email(bidder, auction.id).deliver_later
      end
    end
  end
end