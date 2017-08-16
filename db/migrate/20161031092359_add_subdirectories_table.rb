# frozen_string_literal: true

class AddSubdirectoriesTable < ActiveRecord::Migration
  def change
    create_table :mechanism_subcategories do |t|
      t.text :description
      t.integer :mechanism_category_id
      t.timestamps
    end
  end
end
