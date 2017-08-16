# frozen_string_literal: true

class AddCityTable < ActiveRecord::Migration
  def change
    create_table(:cities) do |t|
      t.string :name
    end
  end
end
