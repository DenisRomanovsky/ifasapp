# frozen_string_literal: true

ActiveAdmin.register MechanismCategory do
  permit_params :description, :home_description
end
