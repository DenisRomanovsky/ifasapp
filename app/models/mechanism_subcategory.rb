# frozen_string_literal: true

# == Schema Information
#
# Table name: mechanism_subcategories
#
#  id                    :integer          not null, primary key
#  description           :text
#  mechanism_category_id :integer
#  created_at            :datetime
#  updated_at            :datetime
#

class MechanismSubcategory < ActiveRecord::Base
  belongs_to :mechanism_category
end
