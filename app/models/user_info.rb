# frozen_string_literal: true

# == Schema Information
#
# Table name: user_infos
#
#  id                :integer          not null, primary key
#  first_name        :string
#  last_name         :string
#  phone_number      :string
#  city_id           :integer
#  user_status_cd    :integer
#  created_at        :datetime
#  updated_at        :datetime
#  send_email        :boolean          default(TRUE)
#  organization_name :string
#

# User personal information. For auction end mails.
class UserInfo < ActiveRecord::Base
  has_one :user
  belongs_to :city

  validates_length_of :first_name, :last_name, :phone_number, :organization_name, maximum: 50

  def full_info?
    first_name.present? && last_name.present? && phone_number.present? && city_id.present?
  end
end
