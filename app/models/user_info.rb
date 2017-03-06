class UserInfo < ActiveRecord::Base
  has_one :user

  validates_length_of :first_name, :last_name, :phone_number, :unp, maximum: 50
end