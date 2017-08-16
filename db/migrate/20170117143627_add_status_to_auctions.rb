# frozen_string_literal: true

class AddStatusToAuctions < ActiveRecord::Migration
  def change
    add_column :auctions, :status, :integer
    add_index  :auctions, :status
    remove_index :auctions, %i[start_time end_time]
  end
end
