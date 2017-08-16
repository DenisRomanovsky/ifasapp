# frozen_string_literal: true

class AddSlugToCategories < ActiveRecord::Migration
  def change
    add_column :mechanism_categories, :slug, :string, unique: true
  end
end
