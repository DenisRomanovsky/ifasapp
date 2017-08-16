# frozen_string_literal: true

class MechanismCategory < ActiveRecord::Base
  has_many :mechanism_subcategories
  has_one :article

  extend FriendlyId
  friendly_id :description, use: :slugged
end
