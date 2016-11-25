class Auction < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
  belongs_to :mechanism_subcategory
  has_many :mechanisms, through: :auction_mechanisms

  validates_presence_of :description, :user_id
  validate do |auction|
    auction.must_be_in_future
  end


  def must_be_in_future
    errors.add(:start_time, 'Даты начала и старта аукциона должны быть в будущем.') if start_time < Time.current
    errors.add(:end_time, 'Даты начала и старта аукциона должны быть в будущем.') if end_time < Time.current
  end
end
