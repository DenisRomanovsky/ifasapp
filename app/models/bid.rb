class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :mechanism
  belongs_to :auction

  enum status: [ :active, :archived ]

  validates_presence_of :mechanism, :auction, :user, :price, :description
end
