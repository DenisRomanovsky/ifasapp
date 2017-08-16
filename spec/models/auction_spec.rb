# frozen_string_literal: true

# == Schema Information
#
# Table name: auctions
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  start_time            :datetime
#  end_time              :datetime
#  description           :text
#  created_at            :datetime
#  updated_at            :datetime
#  mechanism_category_id :integer
#  status                :integer
#  delivery_included     :boolean
#  cash_payed            :boolean
#  with_tax              :boolean
#  user_email            :string
#

require 'rails_helper'

RSpec.describe Auction, type: :model do
  it { should have_many(:items).dependent(:destroy) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:created_by) }

  it 'validates owner' do
    raise 'TBD'
  end

  it 'sends opportunity email' do
    raise 'TBD'
  end

  it 'returns amount of potential bidders' do
    raise 'TBD'
  end

  it 'returns amount of bidders' do
    raise 'TBD'
  end

  it 'sets correct duration' do
    raise 'TBD'
  end
end
