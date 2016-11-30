class RemoveAuctionMechIdFromBidders < ActiveRecord::Migration
  def change
    remove_column(:bids, :auction_mechanism_id)
  end
end
