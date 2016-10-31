class AddUnpIdToUserInfo < ActiveRecord::Migration
  def change
    add_column :user_infos, :unp, :string
  end
end
