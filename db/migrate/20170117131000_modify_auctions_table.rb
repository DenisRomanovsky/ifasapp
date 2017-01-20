class ModifyAuctionsTable < ActiveRecord::Migration
  def up
    remove_column :auctions, :status_cd
    remove_column :auctions, :organization_id
    add_index :auctions, [:start_time, :end_time]
  end

  def down
    puts 'NOPE'
  end
end
