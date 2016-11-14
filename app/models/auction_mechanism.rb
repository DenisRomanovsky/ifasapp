class AuctionMechanism < ActiveRecord::Base
  belongs_to :auction
  belongs_to :mechanism
end
