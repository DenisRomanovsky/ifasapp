require 'rails_helper'

RSpec.describe BidsController, type: :controller do
  describe 'bids setting' do
    render_views

    let!(:user) { FactoryGirl.create(:user) }
    let!(:user_2) { FactoryGirl.create(:user) }

    let!(:category) { FactoryGirl.create(:mechanism_category, :with_subcats) }
    let!(:category_2) { FactoryGirl.create(:mechanism_category, :with_subcats) }
    let!(:auction_with_category) { FactoryGirl.create(:auction, owner: user_2, mechanism_category: category) }
    let!(:auction_with_wrong_category) { FactoryGirl.create(:auction, owner: user_2, mechanism_category: category_2) }

    let!(:mechanism_1) {  FactoryGirl.create(:mechanism,
                                             mechanism_category: category,
                                             mechanism_subcategory: auction_with_category.mechanism_subcategories.first,
                                             user: user)}

    before do
      ApplicationController.any_instance.stub(:authenticate_user!).and_return(true)
      ApplicationController.any_instance.stub(:current_user).and_return(user)
    end

    it 'allows opening of setting bid page' do
      get :new, auction_id: auction_with_category.id
      expect(response.status).to eq(200)
    end

    it 'allows setting bid' do
      expect {
        post :create, auction_id: auction_with_category.id, bid: {price: 100, description: 'New price', mechanism_id: mechanism_1.id}
      }.to change { Bid.all.size }.by(1)
      expect(response.status).to eq(302)
      expect(Bid.last.description).to eq('New price')
    end

    it 'allows setting new bid' do
      expect {
        post :create, auction_id: auction_with_category.id, bid: {price: 100, description: 'Old price', mechanism_id: mechanism_1.id}
        post :create, auction_id: auction_with_category.id, bid: {price: 200, description: 'One more bid price', mechanism_id: mechanism_1.id}
      }.to change { Bid.all.size }.by(2)
      expect(Bid.active.last.description).to eq('One more bid price')
      expect(Bid.archived.last.description).to eq('Old price')
    end

    it 'forbids setting new bid' do
      expect {
        post :create, auction_id: auction_with_wrong_category.id, bid: {price: 100, description: 'Old price', mechanism_id: mechanism_1.id}
      }.to raise_error(ActionController::RoutingError)
    end

    it 'forbids  opening of setting bid page' do
      expect {
        get :new, auction_id: auction_with_wrong_category.id
      }.to raise_error(ActionController::RoutingError)
    end
  end
end
