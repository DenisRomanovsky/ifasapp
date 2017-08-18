# frozen_string_literal: true

class HomeController < ApplicationController
  # before_action :authenticate_user!

  def index
    redirect_to edit_profile_path unless current_user.has_info?
    @categories = MechanismCategory.order('id ASC').all
  end
end
