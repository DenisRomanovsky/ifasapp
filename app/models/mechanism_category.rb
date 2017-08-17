# frozen_string_literal: true

# == Schema Information
#
# Table name: mechanism_categories
#
#  id               :integer          not null, primary key
#  description      :text
#  created_at       :datetime
#  updated_at       :datetime
#  home_description :text
#  slug             :string
#

# Mech category.
class MechanismCategory < ActiveRecord::Base
  has_many :mechanism_subcategories
  has_one :article

  extend FriendlyId
  friendly_id :description, use: :slugged
end
