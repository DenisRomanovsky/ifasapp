# frozen_string_literal: true

class AddMechanismIdToBids < ActiveRecord::Migration
  def change
    add_column(:bids, :mechanism_id, :integer)
  end
end
