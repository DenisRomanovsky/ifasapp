class UserInfosController < ApplicationController

  before_action :authenticate_user!

  def edit
    return unless current_user
    @user_info = UserInfo.where(user_id: current_user.id).first_or_create
  end

  def update
    @user_info = current_user.user_info
    if @user_info.update_attributes(user_info_params)
      redirect_to root_path, flash: { alert: 'Изменения сохранены.' }
    else
      redirect_to edit_user_info_path
    end
  end

  private

  def user_info_params
    params.require(:user_info).permit(:first_name, :last_name, :unp, :phone_number, :city_id)
  end
end
