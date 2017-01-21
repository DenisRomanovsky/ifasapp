class AuctionsController < ApplicationController
  include ApplicationHelper

  before_action :authenticate_user!

  def new
    @auction = Auction.new
    @auction_category_id = MechanismSubcategory.find(params['mech_subcategory']).mechanism_category_id if params['mech_subcategory']
  end

  def create
    auction_parameters = auction_params
    time_now = Time.now.utc + 5.seconds
    auction_parameters.merge!({user_id: current_user.id, start_time: time_now, status: :active})
    @auction = Auction.new(auction_parameters)

    if @auction.save
      redirect_to auctions_path, flash: { notice: 'Аукцион создан.' }
      @auction.sent_opportunity_emails
    else
      render action: 'edit', auction: params[:auction]
    end
  end

  def show
    @auction = current_user.auctions.where(id: params[:id]).first
    raise ActionController::RoutingError.new('Страница не найдена') unless @auction.present?
    @bids = @auction.bids.active.joins(:mechanism).order('price ASC')
  end

  def edit
    @auction = Auction.where(user_id: current_user.id, id: params[:id].to_i).first
    raise ActionController::RoutingError.new('Страница не найдена') unless @auction.present?
  end

  def update
    @auction = Auction.where(user_id: current_user.id, id: params[:id].to_i).first
    if @auction.update_attributes(auction_params)
      redirect_to auctions_path, flash: { notice: 'Изменения сохранены.' }
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
      @opportunies = Auction
                         .active
                         .where('mechanism_category_id in (?) AND (mechanism_subcategory_id in (?) OR mechanism_subcategory_id IS NULL) AND user_id != ?', mechanisms.pluck(:mechanism_category_id), mechanisms.pluck(:mechanism_subcategory_id), current_user.id)
    end
  end

  def show_opportunity
    @opportunity = Auction.where(id: params[:id]).first
    raise ActionController::RoutingError.new('Страница не найдена') if  !user_can_participate? || @opportunity.blank?
    @current_bid = Bid.where(auction_id: params[:id], user_id: current_user.id).active.first
    @total_bids = Bid.where(auction_id: params[:id]).active.size
  end

  private

  def auction_params
    params.require(:auction).permit(:start_time, :end_time, :description, :mechanism_subcategory_id, :mechanism_category_id)
  end

end