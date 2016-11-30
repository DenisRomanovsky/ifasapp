class RemoveRedundantTable < ActiveRecord::Migration
  def up
    drop_table(:auction_mechanisms)
  end
end
