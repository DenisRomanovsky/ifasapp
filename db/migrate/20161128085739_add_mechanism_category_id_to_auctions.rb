class AddMechanismCategoryIdToAuctions < ActiveRecord::Migration
  def change
    add_column :auctions, :mechanism_category_id, :integer
  end
end
