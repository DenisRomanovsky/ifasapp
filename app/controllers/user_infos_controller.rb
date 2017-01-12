class UserInfosController < ApplicationController

  before_action :authenticate_user!

  def edit
    raise ActionController::RoutingError.new('Страница не найдена') unless current_user.present?

    if current_user.user_info.present?
      @user_info = current_user.user_info
    else
      @user_info = current_user.create_user_info
    end
  end

  def update
    @user_info = current_user.user_info
    if @user_info.update_attributes(user_info_params)
      redirect_to root_path, flash: { notice: 'Изменения сохранены.' }
    else
      render action: 'edit', user_info: params[:user_info]
    end
  end

  private

  def user_info_params
    params.require(:user_info).permit(:first_name, :last_name, :unp, :phone_number, :city_id)
  end
end
