module ApplicationHelper
  def user_can_participate?
    auction = Auction.where(id: params[:auction_id] || params[:id]).first
    return false if auction.blank? || auction.user_id == current_user.id
    current_user.mechanisms.pluck(:mechanism_subcategory_id).include?(auction.mechanism_subcategory_id) ||
        (auction.mechanism_subcategory_id.nil? &&
            current_user.mechanisms.pluck(:mechanism_category_id).include?(auction.mechanism_category_id))
  end
end
