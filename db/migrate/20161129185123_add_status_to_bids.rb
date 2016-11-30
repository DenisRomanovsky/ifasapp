class AddStatusToBids < ActiveRecord::Migration
  def change
    add_column :bids, :status, :integer, default: 0
    add_index :bids, :status
  end
end
