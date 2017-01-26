class RemoveSubcategoryFromAuctions < ActiveRecord::Migration
  def up
    remove_column :auctions, :mechanism_subcategory_id
  end

  def down
    puts 'Irreversible'
  end
end
