class MechanismsTable < ActiveRecord::Migration
  def change
    create_table :mechanisms do |t|
      t.integer :mechanism_category_id
      t.integer :mechanism_subcategory_id
      t.string :description
      t.text :long_description
      t.timestamps
    end
    add_index :mechanisms, [:mechanism_category_id, :mechanism_subcategory_id], name: 'by_category_subcategory'
  end
end
