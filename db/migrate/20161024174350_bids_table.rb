# frozen_string_literal: true

class BidsTable < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.float :price
      t.integer :auction_mechanism_id
      t.text :description
      t.integer :user_id
      t.integer :auction_id
      t.timestamps
    end
    add_index :bids, :user_id
    add_index :bids, :auction_id
  end
end
