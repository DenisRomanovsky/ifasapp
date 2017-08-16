# frozen_string_literal: true

# == Schema Information
#
# Table name: mechanisms
#
#  id                       :integer          not null, primary key
#  mechanism_category_id    :integer
#  mechanism_subcategory_id :integer
#  description              :string
#  long_description         :text
#  created_at               :datetime
#  updated_at               :datetime
#  user_id                  :integer
#

class Mechanism < ActiveRecord::Base
  belongs_to :user
  belongs_to :mechanism_subcategory
  belongs_to :mechanism_category
  has_many :auctions, through: :auction_mechanisms

  self.per_page = 10

  validates_presence_of :description
  validates_length_of :description, maximum: 500
end
