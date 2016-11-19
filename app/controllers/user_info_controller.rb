class UserInfoController < ApplicationController

  before_action :authenticate_user!

  def new
    @user_info = current_user.user_info || current_user.user_info.new
  end

  def create
    return id current_user.user_info.present?
    current_user.user_info.build(user_info_params)
    current_user.user_info.save
    render :ok
  end

  def update
    current_user.user_info.update_attributes(user_info_params)
  end

  def cities
    render :json, City.all.to_json
  end

  private

  def user_info_params

  end
end
