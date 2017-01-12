
class SendUserEmailWorker
  @queue = :send_user_email

  @retry_limit = 1
  @retry_delay = 60

  def self.perform(user_id, auction_id, type)
    user = User.find(user_id)
    case type
      when 'new_opportunity'
        UserMailer.new_opportunity_email(user, auction_id).deliver
      else
        puts 'Unknown email type'
    end
  end
end