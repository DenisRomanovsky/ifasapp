# frozen_string_literal: true

class AddEmailToAuction < ActiveRecord::Migration
  def change
    add_column :auctions, :user_email, :string
  end
end
