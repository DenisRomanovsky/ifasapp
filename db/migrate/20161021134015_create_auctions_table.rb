# frozen_string_literal: true

class CreateAuctionsTable < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.integer :user_id
      t.integer :organization_id
      t.datetime :start_time
      t.datetime :end_time
      t.integer :status_cd
      t.text :description
      t.timestamps
    end

    add_index :auctions, :user_id
    add_index :auctions, :organization_id
    add_index :auctions, :status_cd
  end
end
