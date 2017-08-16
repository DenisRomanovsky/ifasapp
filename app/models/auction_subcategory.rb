# frozen_string_literal: true

class AuctionSubcategory < ActiveRecord::Base
  belongs_to :auction
  belongs_to :mechanism_subcategory
end
