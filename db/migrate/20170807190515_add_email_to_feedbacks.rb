# frozen_string_literal: true

class AddEmailToFeedbacks < ActiveRecord::Migration
  def change
    add_column :feedbacks, :email, :string
  end
end
