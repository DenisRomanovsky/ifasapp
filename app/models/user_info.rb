class UserInfo < ActiveRecord::Base
  has_one :user
  belongs_to :city

  validates_length_of :first_name, :last_name, :phone_number, :unp, maximum: 50
end