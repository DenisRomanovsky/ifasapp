# frozen_string_literal: true

# == Schema Information
#
# Table name: auctions
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  start_time            :datetime
#  end_time              :datetime
#  description           :text
#  created_at            :datetime
#  updated_at            :datetime
#  mechanism_category_id :integer
#  status                :integer
#  delivery_included     :boolean
#  cash_payed            :boolean
#  with_tax              :boolean
#  user_email            :string
#

class Auction < ActiveRecord::Base
  belongs_to :owner, class_name: 'User', foreign_key: :user_id
  belongs_to :mechanism_category

  has_many :mechanism_subcategories, through: :auction_subcategories
  has_many :auction_subcategories

  has_many :bids
  has_many :mechanisms, through: :bids

  enum status: %i[active finished]

  self.per_page = 10

  validates_presence_of :description, :start_time, :end_time, :mechanism_category_id
  validates_length_of :description, maximum: 1000
  validates_format_of :user_email, with: Devise.email_regexp, allow_blank: true

  validate(&:validate_owner)

  def validate_owner
    if user_id.blank? && user_email.blank?
      errors.add(:user_email, 'Необходимо указать адрес для получения результата аукциона')
    end
  end

  def sent_opportunity_emails(current_user)
    users = Auction.users_by_mech_cats(mechanism_category_id, auction_subcategories.pluck(:mechanism_subcategory_id))
    users = users.where('users.id != ?', current_user.id).uniq if current_user.present?

    users.each do |user|
      UserMailer.new_opportunity_email(user.id, id).deliver_later
    end
  end

  def self.allowed_bidders_amount(mechanism_category_id, mechanism_subcategory_ids, current_user)
    users = users_by_mech_cats(mechanism_category_id, mechanism_subcategory_ids)
    users = users.map(&:id).uniq.compact
    users.delete(current_user.id) if current_user.present?
    users.size
  end

  def self.users_by_mech_cats(mechanism_category_id, mechanism_subcategory_ids)
    mechanism_subcategory_ids = mechanism_subcategory_ids.nil? ? [] : mechanism_subcategory_ids.uniq.compact
    users = User.joins(:mechanisms).where('"mechanisms"."mechanism_category_id" = ?', mechanism_category_id)
    users = users.where(' "mechanisms"."mechanism_subcategory_id" in (?)', mechanism_subcategory_ids) if mechanism_subcategory_ids.present?
    users
  end

  def bidders
    User.joins(:bids).where('"bids".auction_id = ?', id).group('"users".id')
  end

  def self.durations
    [
      { id: 1,
        text: '20 минут',
        duration: 20.minutes },
      { id: 2,
        text: '1 час',
        duration: 1.hour },
      { id: 3,
        text: '1 день',
        duration: 1.day },
      { id: 4,
        text: '1 неделя',
        duration: 1.week }
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

  def check_user_can_bid!(user)
    raise ActionController::RoutingError, 'Страница не найдена' unless AuctionsRetriever
                                                                       .user_opportunities(user)
                                                                       .pluck(:id)
                                                                       .include?(id)
  end
end
