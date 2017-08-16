# frozen_string_literal: true

class ArticlesTable < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :mechanism_category_id
      t.text :article_text
      t.timestamps
      t.index :mechanism_category_id
    end
  end
end
