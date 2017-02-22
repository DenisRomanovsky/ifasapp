class Auction < ActiveRecord::Base
  belongs_to :owner, class_name: 'User', foreign_key: :user_id
  belongs_to :mechanism_category

  has_many :mechanism_subcategories, through: :auction_subcategories
  has_many :auction_subcategories

  has_many :bids
  has_many :mechanisms, through: :bids

  enum status: [ :active, :finished ]

  validates_presence_of :description, :user_id, :start_time, :end_time, :mechanism_category_id

  validate do |auction|
    auction.must_be_in_future
    auction.validate_times
  end

  def must_be_in_future
    if start_time.present? && end_time.present?
      #errors.add(:start_time, 'Время начала и старта аукциона должны быть в будущем.') if start_time < Time.current
      errors.add(:end_time, 'Время окончания аукциона должно быть в будущем.') if end_time < Time.current
    end
  end

  def validate_times
    if start_time.present? &&  end_time.present?
      errors.add(:end_time, "Время начала аукциона (#{start_time.strftime("%d/%m/%Y %R")}) должно быть раньше времени окончания.") if start_time > end_time
    end
  end

  def sent_opportunity_emails
    users = User.joins(:mechanisms).where('"mechanisms"."mechanism_category_id" = ?', self.mechanism_category_id)
    users = users.where(' "mechanisms"."mechanism_subcategory_id" in (?)', self.auction_subcategories.pluck(:mechanism_subcategory_id)) if  self.auction_subcategories.present?

    users.each do |user|
      UserMailer.new_opportunity_email(user, self.id).deliver_later if user.send_email?
    end
  end

  def bidders
    User.joins(:bids).where('"bids".auction_id = ?', self.id).group('"users".id')
  end

  def self.durations
    [
        {id: 1,
         text: '20 минут',
         duration: 20.minutes},
        {id: 2,
         text: '1 час',
         duration: 1.hour},
        {id: 3,
         text: '1 день',
         duration: 1.day},
        {id: 4,
         text: '1 неделя',
         duration: 1.week}
    ]
  end

  def self.set_end_time(time_now, type)
    result = time_now

    case type.to_i
      when 1
        result += Auction.durations[0][:duration]
      when 2
        result += Auction.durations[1][:duration]
      when 3
        result += Auction.durations[2][:duration]
      when 4
        result += Auction.durations[3][:duration]
      else
        puts 'Incorrect auction duration.'
        result += Auction.durations[0][:duration]
    end

    result
  end
end
