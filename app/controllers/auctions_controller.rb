class AuctionsController < ApplicationController

  before_action :authenticate_user!

  def new
    @auction = Auction.new
  end

  def create
    auction_parameters = auction_params
    auction_parameters.merge!({user_id: current_user.id})
    @auction = Auction.new(auction_parameters)

    if @auction.save
      redirect_to auctions_path, flash: { alert: 'Аукцион создан.' }
    else
      redirect_to new_auction_path
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
      redirect_to edit_auction_path
    end
  end

  def index
    @auctions = Auction.where(user_id: current_user.id).includes(:mechanism_subcategory)
  end

  private

  def auction_params
    params.require(:auction).permit(:start_time, :end_time, :description, :mechanism_subcategory_id)
  end

end