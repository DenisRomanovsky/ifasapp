class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :auction_mechanism
  belongs_to :auction
end
