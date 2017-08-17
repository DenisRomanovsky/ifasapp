# frozen_string_literal: true

# Retrieve opportunities for a bidder.
class AuctionsRetriever
  def self.user_opportunities(user)
    user_mechanisms = user.mechanisms.load
    Auction
      .joins('LEFT JOIN auction_subcategories ON auction_subcategories.auction_id = auctions.id')
      .active
      .where.not(owner: user)
      .where(
        'auction_subcategories.mechanism_subcategory_id in (?)
        OR
        (auctions.mechanism_category_id in (?) AND auction_subcategories.auction_id IS NULL)',
        user_mechanisms.map(&:mechanism_subcategory_id),
        user_mechanisms.map(&:mechanism_category_id)
      )
  end
end
