# frozen_string_literal: true

class MechanismSubcategory < ActiveRecord::Base
  belongs_to :mechanism_category
end
