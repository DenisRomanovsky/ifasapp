# frozen_string_literal: true

ActiveAdmin.register Mechanism do
  permit_params :mechanism_category_id, :mechanism_subcategory_id, :description, :long_description, :user_id
end
