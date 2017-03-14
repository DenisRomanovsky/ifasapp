require 'rails_helper'

RSpec.describe Auction, type: :model do

  it { should have_many(:items).dependent(:destroy) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:created_by) }

  it 'validates owner' do
    fail 'TBD'
  end

  it 'sends opportunity email' do
    fail 'TBD'
  end

  it 'returns amount of potential bidders' do
    fail 'TBD'
  end

  it 'returns amount of bidders' do
    fail 'TBD'
  end

  it 'sets correct duration' do
    fail 'TBD'
  end
end