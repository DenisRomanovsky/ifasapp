# frozen_string_literal: true

class RegionsTable < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
    end
  end
end
