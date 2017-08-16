class AuctionsRetriever
  def self.user_opportunities(user)
    user_id = user.id
    Auction
        .joins(:auction_subcategories)
        .active
        .where.not.(owner: user)
        .where('auctions.mechanism_category_id in (?)', mechanisms.pluck(:mechanism_category_id))
  end
end