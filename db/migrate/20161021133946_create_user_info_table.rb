# frozen_string_literal: true

class CreateUserInfoTable < ActiveRecord::Migration
  def change
    create_table :user_infos do |t|
      t.string :user_id
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.integer :city_id
      t.integer :user_status_cd
      t.timestamps
    end
    add_index :user_infos, :user_id
  end
end
