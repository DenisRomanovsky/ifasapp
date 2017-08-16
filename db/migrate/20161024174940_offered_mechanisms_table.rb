# frozen_string_literal: true

class OfferedMechanismsTable < ActiveRecord::Migration
  def change
    create_table :auction_mechanisms do |t|
      t.integer :auction_id
      t.integer :mechanism_id

      t.timestamps
    end
    add_index :auction_mechanisms, :auction_id
  end
end
