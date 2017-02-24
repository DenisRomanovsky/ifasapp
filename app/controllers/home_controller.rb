class HomeController < ApplicationController

  #before_action :authenticate_user!

  def index
    @categories = MechanismCategory.order('description').all
  end
end
