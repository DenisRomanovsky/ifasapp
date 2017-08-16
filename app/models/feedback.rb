# frozen_string_literal: true

class Feedback < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :feedback_text, :email
  validates_length_of :feedback_text, maximum: 2000
  validates_format_of :email, with: /\A(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})\z/i

  def send_to_admin
    UserMailer.feedback_received_email(id).deliver_later
  end
end
