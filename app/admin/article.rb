# frozen_string_literal: true

ActiveAdmin.register Article do
  permit_params :mechanism_category_id, :article_text
end
