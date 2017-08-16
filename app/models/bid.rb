# frozen_string_literal: true
# == Schema Information
#
# Table name: bids
#
#  id           :integer          not null, primary key
#  price        :float
#  description  :text
#  user_id      :integer
#  auction_id   :integer
#  created_at   :datetime
#  updated_at   :datetime
#  status       :integer          default(0)
#  mechanism_id :integer
#


class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :mechanism
  belongs_to :auction

  enum status: %i[active archived]

  self.per_page = 10

  validates_presence_of :mechanism, :auction, :user, :price, :description
  validates_length_of :description, maximum: 500
end
