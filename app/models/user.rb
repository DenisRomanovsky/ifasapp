class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable#, :confirmable

  belongs_to :user_info
  has_many :auctions
  has_many :bids
  has_many :mechanisms

  validates_uniqueness_of :user_info_id, allow_nil: true

  validates_format_of :email,:with => Devise::email_regexp
end
