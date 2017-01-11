class Auction < ActiveRecord::Base
  belongs_to :user
  belongs_to :mechanism_subcategory
  belongs_to :mechanism_category
  has_many :bids
  has_many :mechanisms, through: :bids

  validates_presence_of :description, :user_id, :start_time, :end_time, :mechanism_category_id
  validate do |auction|
    auction.must_be_in_future
    auction.validate_times
  end


  def must_be_in_future
    errors.add(:start_time, 'Время начала и старта аукциона должны быть в будущем.') if start_time < Time.current
    errors.add(:end_time, 'Время начала и старта аукциона должны быть в будущем.') if end_time < Time.current
  end

  def validate_times
    errors.add(:start_time, 'Время начала аукциона должно быть раньше времени окончания.') if start_time > end_time
  end
end
