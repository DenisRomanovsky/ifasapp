class UserMailer < ApplicationMailer

  def new_opportunity_email(user_id, opportunity_id)
    @user = User.includes(:user_info).find(user_id)

    return  if @user.user_info.present? &&  !@user.user_info.send_email?

    @opportunity_id = opportunity_id
    mail(to: @user.email, subject: 'ifasapp: Новый аукцион: спрос на Вашу технику.')
  end

  def auction_finished_owner_email(user_id, auction_id)
    @user = User.find(user_id)
    @auction_id = auction_id
    mail(to: @user.email, subject: 'ifasapp: Аукцион окончен: доступны результаты.')
  end

  def auction_finished_bidder_email(user_id,opportunity_id)
    @user = User.find(user_id)
    @opportunity_id = opportunity_id
    mail(to: @user.email, subject: 'ifasapp: Аукцион окончен.')
  end
end
