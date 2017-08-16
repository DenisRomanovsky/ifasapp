# frozen_string_literal: true

ActiveAdmin.register Auction do
  permit_params :user_id, :start_time, :end_time, :description, :mechanism_category_id, :status, :delivery_included, :cash_payed, :with_tax, :user_email
end
