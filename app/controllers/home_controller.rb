class HomeController < ApplicationController

  #before_action :authenticate_user!

  def index
    @categories = MechanismSubcategory.includes(:mechanism_category).group_by{ |m| m.mechanism_category}
  end
end
