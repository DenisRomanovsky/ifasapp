require 'rails_helper'

RSpec.describe 'AuctionsRetriever', type: :service do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:user_2) { FactoryGirl.create(:user) }
  let!(:category) { FactoryGirl.create(:mechanism_category, :with_subcats) }
  let!(:category_2) { FactoryGirl.create(:mechanism_category, :with_subcats) }
  let!(:category_3) { FactoryGirl.create(:mechanism_category, :with_subcats) }


  let(:auction_with_category) { FactoryGirl.create(:auction, owner: user_2, mechanism_category: category) }
  let(:auction_with_subcats) { FactoryGirl.create(:auction, :with_subcats, owner: user_2, mechanism_category: category_2) }
  let(:auction_with_wrong_subcats) { FactoryGirl.create(:auction, :with_subcats, owner: user_2, mechanism_category: category_3) }
  let(:auction_with_wrong_category) { FactoryGirl.create(:auction, owner: user_2, mechanism_category: category_3) }

  it 'retrieves active auctions based on mech category' do
    FactoryGirl.create(:mechanism,
                       mechanism_category: category,
                       mechanism_subcategory: auction_with_category.mechanism_subcategories.first,
                       user: user)

    result = AuctionsRetriever.user_opportunities(user)
    expect(result.size).to eq(1)
    expect(result.first.id).to eq(auction_with_category.id)
  end

  it 'retrieves active auctions based on mech subcategories' do
    FactoryGirl.create(:mechanism,
                       mechanism_category: category_2,
                       mechanism_subcategory: auction_with_subcats.mechanism_subcategories.last,
                       user: user)

    result = AuctionsRetriever.user_opportunities(user)
    expect(result.size).to eq(1)
    expect(result.first.id).to eq(auction_with_subcats.id)
  end

  it 'skips owned auctions' do
    auction_with_category
    result = AuctionsRetriever.user_opportunities(user_2)
    expect(result.size).to eq(0)
  end

  it 'skips finished auctions' do
    FactoryGirl.create(:mechanism,
                       mechanism_category: category,
                       mechanism_subcategory: auction_with_category.mechanism_subcategories.first,
                       user: user)

    auction_with_category.finished!
    result = AuctionsRetriever.user_opportunities(user)
    expect(result.size).to eq(0)
  end

  it 'skips auctions with wrong subcats' do
    auction_with_wrong_subcats
    result = AuctionsRetriever.user_opportunities(user)
    expect(result.size).to eq(0)
  end

  it 'skips auctions with wrong category' do
    auction_with_wrong_category
    result = AuctionsRetriever.user_opportunities(user)
    expect(result.size).to eq(0)
  end
end
