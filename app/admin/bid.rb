ActiveAdmin.register Bid do
  permit_params :price, :description, :user_id, :auction_id, :mechanism_id, :status
end
