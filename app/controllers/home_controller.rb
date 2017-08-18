# frozen_string_literal: true

class HomeController < ApplicationController
  # before_action :authenticate_user!

  def index
    unless current_user.has_info?
      flash[:notice] = 'Заполните все поля, пожалуйста.'
      redirect_to edit_profile_path
    end

    @categories = MechanismCategory.order('id ASC').all
  end
end
