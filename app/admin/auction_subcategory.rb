# frozen_string_literal: true

ActiveAdmin.register AuctionSubcategory do
  permit_params :auction_id, :mechanism_subcategory_id
end
