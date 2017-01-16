class SendUserEmailJob < ActiveJob::Base
  queue_as :default

  def perform(user_id, auction_id, type)
    user = User.find(user_id)
    case type
      when 'new_opportunity'
        UserMailer.new_opportunity_email(user, auction_id).deliver
      else
        puts 'Unknown email type'
    end
  end
end