# frozen_string_literal: true

class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :mechanism
  belongs_to :auction

  enum status: %i[active archived]

  self.per_page = 10

  validates_presence_of :mechanism, :auction, :user, :price, :description
  validates_length_of :description, maximum: 500
end
