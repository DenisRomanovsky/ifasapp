# frozen_string_literal: true

class RemoveRedundantTable < ActiveRecord::Migration
  def up
    drop_table(:auction_mechanisms)
  end
end
