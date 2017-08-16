# frozen_string_literal: true

ActiveAdmin.register MechanismSubcategory do
  permit_params :description, :mechanism_category_id
end
