class UserMailer < ApplicationMailer

  def new_opportunity_email(user, opportunity_id)
    @user = user
    @opportunity_id = opportunity_id
    mail(to: @user.email, subject: 'Новый аукцион: спрос на Вашу технику.')
  end
end
