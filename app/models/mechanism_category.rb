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

  @@context_data = nil

  def self.context_data
    return @@context_data if @@context_data.present?
    result = []
    City.all.each do |city|
      result << "аренда техники #{city.name} , аренда строительной техники #{city.name}"
      MechanismCategory.all.each do |category|
        result << "аренда #{ category.description } #{city.name} , аренда #{ category.description } в #{city.name}"
      end
    end

    @@context_data ||= result.join(' , ')
  end
end
