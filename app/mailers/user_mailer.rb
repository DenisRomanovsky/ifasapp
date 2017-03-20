class UserMailer < ApplicationMailer

  def new_opportunity_email(user_id, opportunity_id)
    @user = User.includes(:user_info).find(user_id)

    return  if @user.user_info.present? &&  !@user.user_info.send_email?

    @opportunity_id = opportunity_id
    mail(to: @user.email, subject: 'Артель - Новый аукцион: спрос на Вашу технику.')
  end

  def auction_finished_owner_email(user_email, auction_id)
    @auction = Auction.find(auction_id)
    @bids = Bid.where(auction_id: auction_id).includes(:user)
    mail(to: user_email, subject: 'Артель - Аукцион окончен: доступны результаты.')
  end

  def auction_finished_bidder_email(user_id,opportunity_id)
    @user = User.find(user_id)
    @opportunity_id = opportunity_id
    mail(to: @user.email, subject: 'Артель - Аукцион окончен.')
  end

  def feedback_received_email(feedback_id)
    @feedback = Feedback.includes(:user).find(feedback_id)
    mail(to: ENV['ADMIN_EMAIL']|| 'niafasmail@gmail.com', subject: 'Артель - Отзыв от пользователя.')
  end
end
