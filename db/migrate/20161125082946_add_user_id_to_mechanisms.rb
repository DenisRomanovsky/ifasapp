class AddUserIdToMechanisms < ActiveRecord::Migration
  def change
    add_column :mechanisms, :user_id, :integer
    add_index :mechanisms, :user_id
  end
end
