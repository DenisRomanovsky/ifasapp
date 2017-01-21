class Auction < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  belongs_to :mechanism_subcategory
  belongs_to :mechanism_category

  has_many :bids
  has_many :mechanisms, through: :bids
  has_many :bidders, through: :bids, class_name: 'User'

  enum status: [ :active, :finished ]

  validates_presence_of :description, :user_id, :start_time, :end_time, :mechanism_category_id

  validate do |auction|
    auction.must_be_in_future
    auction.validate_times
  end

  def must_be_in_future
    if start_time.present? && end_time.present?
      #errors.add(:start_time, 'Время начала и старта аукциона должны быть в будущем.') if start_time < Time.current
      errors.add(:end_time, 'Время начала и старта аукциона должны быть в будущем.') if end_time < Time.current
    end
  end

  def validate_times
    if start_time.present? &&  end_time.present?
      errors.add(:start_time, 'Время начала аукциона должно быть раньше времени окончания.') if start_time > end_time
    end
  end

  def sent_opportunity_emails
    users = User.joins(:mechanisms).where(' "mechanisms"."mechanism_category_id" = ?', self.mechanism_category_id)
    users = users.where(' "mechanisms"."mechanism_subcategory_id" = ?', self.mechanism_subcategory_id) if  self.mechanism_subcategory_id.present?

    users.each do |user|
      UserMailer.new_opportunity_email(user, self.id).deliver_later
    end
  end
end
