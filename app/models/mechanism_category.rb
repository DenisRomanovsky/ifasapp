class MechanismCategory < ActiveRecord::Base
  has_many :mechanism_subcategories

  extend FriendlyId
  friendly_id :description, use: :slugged

end