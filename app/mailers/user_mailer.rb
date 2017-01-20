class UserMailer < ApplicationMailer

  def new_opportunity_email(user, opportunity_id)
    @user = user
    @opportunity_id = opportunity_id
    mail(to: @user.email, subject: 'ifasapp: Новый аукцион: спрос на Вашу технику.')
  end

  def auction_finished_owner_email(user, auction_id)
    @user = user
    @auction_id = auction_id
    mail(to: @user.email, subject: 'ifasapp: Аукцион окончен: доступны результаты.')
  end

  def auction_finished_bidder_email(user,opportunity_id)
    @user = user
    @opportunity_id = opportunity_id
    mail(to: @user.email, subject: 'ifasapp: Аукцион окончен.')
  end
end
