# frozen_string_literal: true

class AddSendEmailToUsers < ActiveRecord::Migration
  def change
    add_column :user_infos, :send_email, :boolean, default: true
  end
end
