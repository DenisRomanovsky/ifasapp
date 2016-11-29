class AuctionsController < ApplicationController

  before_action :authenticate_user!

  def new
    @auction = Auction.new
    @auction_subcategory_id = params['mech_subcategory']
    @auction_category_id = MechanismSubcategory.find(params['mech_subcategory']).mechanism_category_id
    @categories = MechanismCategory.all
    @sub_categories = MechanismSubcategory.where(mechanism_category_id: @auction_category_id)
  end

  def create
    auction_parameters = auction_params
    auction_parameters.merge!({user_id: current_user.id})
    @auction = Auction.new(auction_parameters)

    if @auction.save
      redirect_to auctions_path, flash: { alert: 'Аукцион создан.' }
    else
      render action: 'edit', auction: params[:auction]
    end
  end

  def show

  end

  def edit
    @auction = Auction.where(user_id: current_user.id, id: params[:id].to_i).first
    raise ActionController::RoutingError.new('Страница не найдена') unless @auction.present?
  end

  def update
    @auction = Auction.where(user_id: current_user.id, id: params[:id].to_i).first
    if @auction.update_attributes(auction_params)
      redirect_to auctions_path, flash: { alert: 'Изменения сохранены.' }
    else
      render action: 'edit', auction: params[:auction]
    end
  end

  def index
    @auctions = Auction.where(user_id: current_user.id).includes(:mechanism_subcategory)
  end

  def update_subcategories
    raise ActionController::RoutingError.new('Страница не найдена') unless request.xhr?
    sub_categories = MechanismSubcategory.select(:id, :description).where(mechanism_category_id: params[:category_id])
    render json: sub_categories.to_json
  end

  def opportunities_index
    @opportunies = []
    mechanisms = current_user.mechanisms
    if mechanisms.present?
      @opportunies = Auction.where('mechanism_category_id in (?) AND (mechanism_subcategory_id in (?) OR mechanism_subcategory_id IS NULL)', mechanisms.pluck(:mechanism_category_id), mechanisms.pluck(:mechanism_subcategory_id))
    end
  end

  private

  def auction_params
    params.require(:auction).permit(:start_time, :end_time, :description, :mechanism_subcategory_id)
  end

end