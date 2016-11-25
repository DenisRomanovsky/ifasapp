class Mechanism < ActiveRecord::Base
  belongs_to :user
  belongs_to :mechanism_subcategory
  belongs_to :mechanism_category
  has_many :auctions, through: :auction_mechanisms
end
