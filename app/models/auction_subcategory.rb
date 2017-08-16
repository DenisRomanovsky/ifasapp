# frozen_string_literal: true
# == Schema Information
#
# Table name: auction_subcategories
#
#  auction_id               :integer
#  mechanism_subcategory_id :integer
#


class AuctionSubcategory < ActiveRecord::Base
  belongs_to :auction
  belongs_to :mechanism_subcategory
end
