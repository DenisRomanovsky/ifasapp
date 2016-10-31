class MechanismCatgoriesTable < ActiveRecord::Migration
  def change
    create_table :mechanism_categories do |t|
      t.text :description
      t.timestamps
    end
  end
end
