module ApplicationHelper
  def user_can_participate?
    auction = Auction.includes(:mechanism_subcategories).active.where(id: params[:auction_id] || params[:id]).first
    return false if auction.blank? || auction.user_id == current_user.id

    user = Auction.users_by_mech_cats(auction.mechanism_category_id, auction.mechanism_subcategories.pluck(:id)).where(id: current_user.id)
    if user.any?
      true
    else
      false
    end
  end

  def minsk_time(time)
    time + 3.hours
  end
end
