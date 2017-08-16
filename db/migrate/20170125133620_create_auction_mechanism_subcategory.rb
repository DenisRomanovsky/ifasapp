# frozen_string_literal: true

class CreateAuctionMechanismSubcategory < ActiveRecord::Migration
  def up
    create_table :auction_subcategories, id: false do |t|
      t.belongs_to :auction
      t.belongs_to :mechanism_subcategory
    end
    add_index :auction_subcategories, %i[auction_id mechanism_subcategory_id], name: 'auction_subcats_idx'
  end

  def down
    drop_table :auction_subcategories
  end
end
