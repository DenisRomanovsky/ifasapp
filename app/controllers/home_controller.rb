class HomeController < ApplicationController

  #before_action :authenticate_user!

  def index
    @categories = MechanismSubcategory.includes(:mechanism_category).group_by{ |m| m.mechanism_category}
  end

  def search_offers
    render json: [{ id: 2, name: 'Baked Potatoes' }, { id: 4, name: 'Potatoes Au Gratin' }].to_json
  end
end
