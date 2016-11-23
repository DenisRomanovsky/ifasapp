class MoveUserInfoIdToUser < ActiveRecord::Migration
  def change
    add_column(:users, :user_info_id, :integer)
    add_index(:users, :user_info_id)
    remove_column(:user_infos, :user_id)
  end
end
