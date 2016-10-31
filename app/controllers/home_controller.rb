class HomeController < ApplicationController

  #before_action :authenticate_user!

  def index

  end

  def search_offers
    render json: [{ id: 2, name: 'Baked Potatoes' }, { id: 4, name: 'Potatoes Au Gratin' }].to_json
  end
end
