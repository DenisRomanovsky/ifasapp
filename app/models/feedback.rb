class Feedback < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :feedback_text
  validates_length_of :feedback_text, maximum: 2000

  def send_to_admin
    UserMailer.feedback_received_email(self.id).deliver_later
  end
end
