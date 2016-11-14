class Mechanism < ActiveRecord::Base
  belongs_to :user
  has_many :auctions, through: :auction_mechanisms
end
