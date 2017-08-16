# frozen_string_literal: true

class AuctionsController < ApplicationController
  include ApplicationHelper

  before_action :authenticate_user!, except: %i[new_unregistered create_unregistered update_subcategories show]
  before_action :set_categories, only: %i[new create new_unregistered create_unregistered]

  def new
    setup_new_auction(current_user)
  end

  def new_unregistered
    setup_new_auction(nil)
  end

  def create
    save_auction
  end

  def create_unregistered
    save_auction
  end

  def show
    if current_user.present?
      @auction = current_user.auctions.where(id: params[:id]).first
      raise ActionController::RoutingError, 'Страница не найдена' unless @auction.present?
      @bids = @auction.bids.paginate(page: params[:page], per_page: 30).includes(:user).active.joins(:mechanism).order('price ASC')
    else
      @auction = Auction.find(params[:id])
    end
  end

  # Not used for now.
  def edit
    @auction = Auction.where(user_id: current_user.id, id: params[:id].to_i).first!

    category = MechanismCategory.find(@auction.category_id)
    @auction_category = category
    @auction_sub_categories = category.mechanism_subcategories

    raise ActionController::RoutingError, 'Страница не найдена' unless @auction.present?
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
    @auctions = Auction.paginate(page: params[:page]).where(user_id: current_user.id).includes(:mechanism_subcategories)
  end

  def update_subcategories
    raise ActionController::RoutingError, 'Страница не найдена' unless request.xhr?
    sub_categories = MechanismSubcategory.select(:id, :description).where(mechanism_category_id: params[:category_id])
    render json: sub_categories.to_json
  end

  def opportunities_index
    @opportunies = []
    mechanisms = current_user.mechanisms

    if mechanisms.present?
      # TODO: Cover this with tests and AFTER refactor to use one god damned SQL query.
      opportunities = Auction
                      .includes(:mechanism_category, :mechanism_subcategories)
                      .active
                      .where('auctions.mechanism_category_id in (?) AND user_id != ?', mechanisms.pluck(:mechanism_category_id), current_user.id)
                      .order('id DESC')

      opportunities = opportunities.map do |op|
        next if op.user_id == current_user.id # check the owner

        if op.mechanism_subcategories.present?
          (op.mechanism_subcategories.pluck(:id).compact.uniq & mechanisms.pluck(:mechanism_subcategory_id).compact.uniq).any? ? op : nil
        else
          op
        end
      end

      opportunities = opportunities.compact.uniq
      @opportunities = Auction.paginate(page: params[:page]).where(id: opportunities)
    end
  end

  def show_opportunity
    @opportunity = Auction.where(id: params[:id]).first
    raise ActionController::RoutingError, 'Страница не найдена' if !user_can_participate? || @opportunity.blank?
    @current_bid = Bid.where(auction_id: params[:id], user_id: current_user.id).active.first
    @total_bids = Bid.where(auction_id: params[:id]).active.size
    time_left = @opportunity.end_time.utc - Time.now.utc
    @time_left = time_left > 0 ? time_left : 0
  end

  def get_bidders_counter
    subcats = params['subcategories_ids'].present? ? params['subcategories_ids'] : []
    users_amount = Auction.allowed_bidders_amount(params['category_id'], subcats, current_user)
    render json: { 'bidders-counter' => users_amount }.to_json
  end

  private

  def auction_params
    params.require(:auction).permit(:end_time, :description, :delivery_included,
                                    :cash_payed, :with_tax, :mechanism_category_id,
                                    :user_email)
  end

  def build_auction_subcats
    auction_subcategories = params.dig(:auction, :auction_subcategories) || []

    auction_subcategories.each do |subcat_id|
      @auction.auction_subcategories.build(mechanism_subcategory_id: subcat_id)
    end
  end

  def set_categories
    category = nil

    if params['category_slug'].present?
      category = MechanismCategory.friendly.find(params['category_slug'])
    elsif params['auction'].present?
      category_id = params.dig(:auction, :mechanism_category_id)
      category = category_id.present? ? MechanismCategory.find(category_id) : MechanismCategory.first
    else
      category = MechanismCategory.first
    end

    @auction_category = category
    @auction_sub_categories = category.mechanism_subcategories
    @auction_article = category.article
  end

  def setup_new_auction(user)
    @auction = Auction.new
    @potential_bidders = Auction.allowed_bidders_amount(params['mechanism_category_id'], nil, user)
  end

  def save_auction
    auction_parameters = auction_params
    time_now = Time.now.utc + 5.seconds

    auction_parameters.merge!(user_id: current_user.present? ? current_user.id : nil,
                              start_time: time_now,
                              status: :active)

    auction_parameters['with_tax'] == '0' if auction_parameters['cash_payed'] == '0'

    @auction = Auction.new(auction_parameters)

    @auction.end_time = Auction.set_end_time(time_now, auction_parameters[:end_time])

    build_auction_subcats

    if @auction.save
      redirect_to auction_path(@auction), flash: { notice: 'Аукцион создан.' }
      @auction.sent_opportunity_emails(current_user)
    else
      @auction_sub_categories_ids = params.dig(:auction, :auction_subcategories)
      @duration_id = params.dig(:auction, :end_time).to_i
      render action: current_user.present? ? 'new' : 'new_unregistered', auction: @auction
    end
  end
end
