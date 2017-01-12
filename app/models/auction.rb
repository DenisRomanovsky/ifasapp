class Auction < ActiveRecord::Base
  belongs_to :user
  belongs_to :mechanism_subcategory
  belongs_to :mechanism_category
  has_many :bids
  has_many :mechanisms, through: :bids

  scope :active, -> { where('end_time < ?', Time.now.utc).where('start_time > ?', Time.now.utc) }

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

  def sent_opportunity_emails
    users = User.joins(:mechanisms).where(' "mechanisms"."mechanism_category_id" = ?', self.mechanism_category_id)
    users = users.where(' "mechanisms"."mechanism_subcategory_id" = ?', self.mechanism_subcategory_id) if  self.mechanism_subcategory_id.present?

    users.pluck(:id).each do |user_id|
      Resque.enqueue(SendUserEmailWorker, user_id, self.id, 'new_opportunity')
    end
  end
end
