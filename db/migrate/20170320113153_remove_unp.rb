# frozen_string_literal: true

class RemoveUnp < ActiveRecord::Migration
  def up
    remove_column :user_infos, :unp
    add_column :user_infos, :organization_name, :string, unique: true
  end
end
