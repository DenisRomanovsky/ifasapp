# frozen_string_literal: true

class AddMechanismSubcategoryToAuctions < ActiveRecord::Migration
  def change
    add_column :auctions, :mechanism_subcategory_id, :integer
  end
end
