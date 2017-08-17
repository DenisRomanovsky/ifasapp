# frozen_string_literal: true

class BidsController < ApplicationController
  include ApplicationHelper
  before_action :set_auction
  before_action :authenticate_user!

  def new
    return if @auction.blank?
    @auction.check_user_can_bid!(current_user)
    @bid = Bid.new
    last_bid = Bid.where(auction_id: params[:auction_id], user_id: current_user.id).active.first
    if last_bid.present?
      @description = last_bid.description
      @price = last_bid.price
      @mechanism = last_bid.mechanism_id
    end
  end

  def create
    return if @auction.blank?
    @auction.check_user_can_bid!(current_user)

    last_bid = Bid.where(auction_id: params[:auction_id], user_id: current_user.id).active.first
    last_bid.update_attribute(:status, :archived) if last_bid.present?

    bid = Bid.new(bid_params)
    bid.user_id = current_user.id
    bid.auction_id = params[:auction_id]

    if bid.save
      redirect_to show_opportunity_path(params[:auction_id]), flash: { notice: 'Ставка сохранена' }
    else
      render action: 'edit', auction: params[:bid]
    end
  end

  def edit
    return if @auction.blank?
    @auction.check_user_can_bid!(current_user)
  end

  private

  def bid_params
    params.require(:bid).permit(:price, :description, :mechanism_id)
  end

  def set_auction
    @auction = Auction.active.where(id: params[:auction_id]).first

    if @auction.blank?
      redirect_to show_opportunity_path(params[:auction_id]), flash: { alert: 'Этот аукцион не существует или уже закончился.' }
    end
  end
end
