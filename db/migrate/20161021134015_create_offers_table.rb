class CreateOffersTable < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.integer :user_id
      t.integer :organization_id
      t.datetime :start_time
      t.datetime :end_time
      t.integer :status_cd
      t.text :description
      t.timestamps
    end

    add_index :offers, :user_id
    add_index :offers, :organization_id
    add_index :offers, :status_cd
  end
end
