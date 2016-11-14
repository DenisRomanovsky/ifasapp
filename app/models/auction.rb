class Auction < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
  has_many :mechanisms, through: :auction_mechanisms
end
