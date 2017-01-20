class AddStatusToAuctions < ActiveRecord::Migration
  def change
    add_column :auctions, :status, :integer
    add_index  :auctions, :status
    remove_index :auctions, [:start_time, :end_time]
  end
end
