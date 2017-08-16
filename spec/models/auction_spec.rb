# frozen_string_literal: true

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
