class AuctionsController < ApplicationController
  include ApplicationHelper

  before_action :authenticate_user!
  before_action :set_categories, only: [:new, :create]

  def new
    @auction = Auction.new
    @potential_bidders = Auction.allowed_bidders_amount(params['mechanism_category_id'], nil, current_user)
  end

  def create
    auction_parameters = auction_params
    time_now = Time.now.utc + 5.seconds

    auction_parameters.merge!({user_id: current_user.id,
                               start_time: time_now,
                               status: :active,
                               mechanism_category_id: params['mechanism_category_id']})

    auction_parameters['with_tax'] == '0' if auction_parameters['cash_payed'] == '0'

    @auction = Auction.new(auction_parameters)

    @auction.end_time = Auction.set_end_time(time_now, auction_parameters[:end_time])

    build_auction_subcats

    if @auction.save
      redirect_to auctions_path, flash: { notice: 'Аукцион создан.' }
      @auction.sent_opportunity_emails(current_user)
    else
      @auction_sub_categories_ids = params.dig(:auction, :auction_subcategories)
      @duration_id = params.dig(:auction, :end_time).to_i
      render action: 'edit', auction: @auction
    end
  end

  def show
    @auction = current_user.auctions.where(id: params[:id]).first
    raise ActionController::RoutingError.new('Страница не найдена') unless @auction.present?
    @bids = @auction.bids.active.joins(:mechanism).order('price ASC')
  end

  #Not used for now.
  def edit
    @auction = Auction.where(user_id: current_user.id, id: params[:id].to_i).first!

    category = MechanismCategory.find(@auction.category_id)
    @auction_category = category
    @auction_sub_categories = category.mechanism_subcategories


    raise ActionController::RoutingError.new('Страница не найдена') unless @auction.present?
  end

  def update
    @auction = Auction.where(user_id: current_user.id, id: params[:id].to_i).first
    if @auction.update_attributes(auction_params)
      @auction.auction_subcategories.delete_all
      create_auction_subcats
      @auction.save
      redirect_to auctions_path, flash: { notice: 'Изменения сохранены.' }
    else
      @block_categories = true
      @auction_category_id = @auction.mechanism_category_id
      @auction_sub_categories = @auction.auction_subcategories.pluck(:mechanism_subcategory_id)
      render action: 'edit', auction: params[:auction]
    end
  end

  def index
    @auctions = Auction.where(user_id: current_user.id).includes(:mechanism_subcategories)
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
                         .includes(:mechanism_category, :mechanism_subcategories)
                         .active
                         .where('auctions.mechanism_category_id in (?) AND user_id != ?', mechanisms.pluck(:mechanism_category_id), current_user.id)
                         .order('id DESC')

      @opportunies = @opportunies.map do |op|
        if op.user_id == current_user.id #check the owner
          next
        end

        if op.mechanism_subcategories.any?
          (op.mechanism_subcategories.pluck(:id).compact.uniq & mechanisms.pluck(:mechanism_subcategory_id).compact.uniq).any? ? op : nil
        else
          op
        end
      end
      @opportunies = @opportunies.compact.uniq
    end
  end

  def show_opportunity
    @opportunity = Auction.where(id: params[:id]).first
    raise ActionController::RoutingError.new('Страница не найдена') if  !user_can_participate? || @opportunity.blank?
    @current_bid = Bid.where(auction_id: params[:id], user_id: current_user.id).active.first
    @total_bids = Bid.where(auction_id: params[:id]).active.size
    time_left = @opportunity.end_time.utc - Time.now.utc
    @time_left = time_left > 0 ? time_left : 0
  end

  def get_bidders_counter
    users_amount = Auction.allowed_bidders_amount(params['category_id'], params['subcategories_ids'], current_user)
    render json: {'bidders-counter' =>  users_amount}.to_json
  end

  private

  def auction_params
    params.require(:auction).permit(:end_time, :description, :delivery_included, :cash_payed, :with_tax)
  end

  def build_auction_subcats
    auction_subcategories = params.dig(:auction, :auction_subcategories) || []

    auction_subcategories.each do |subcat_id|
      @auction.auction_subcategories.build(mechanism_subcategory_id: subcat_id)
    end
  end

  def set_categories
    category_id = params['mechanism_category_id'] || params.dig(:auction, :mechanism_category_id)

    category = MechanismCategory.find(category_id)
    @auction_category = category
    @auction_sub_categories = category.mechanism_subcategories
  end

end