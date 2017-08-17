require 'rails_helper'

RSpec.describe AuctionsController, type: :controller do
  describe 'opportunities' do
    render_views

    let!(:user) { FactoryGirl.create(:user) }
    let!(:user_2) { FactoryGirl.create(:user) }

    let!(:category) { FactoryGirl.create(:mechanism_category, :with_subcats) }
    let!(:category_2) { FactoryGirl.create(:mechanism_category, :with_subcats) }
    let!(:category_3) { FactoryGirl.create(:mechanism_category, :with_subcats) }

    let!(:auction_with_category) { FactoryGirl.create(:auction, owner: user_2, mechanism_category: category) }
    let!(:auction_with_wrong_category) { FactoryGirl.create(:auction, owner: user_2, mechanism_category: category_3) }
    let!(:auction_with_subcats) { FactoryGirl.create(:auction, :with_subcats, owner: user_2, mechanism_category: category_2) }
    let!(:auction_owner) { FactoryGirl.create(:auction, :with_subcats, owner: user, mechanism_category: category) }

    let!(:mechanism_1) {  FactoryGirl.create(:mechanism,
                                             mechanism_category: category,
                                             mechanism_subcategory: auction_with_category.mechanism_subcategories.first,
                                             user: user)}

    let!(:mechanism_2) {  FactoryGirl.create(:mechanism,
                                             mechanism_category: category_2,
                                             mechanism_subcategory: auction_with_subcats.mechanism_subcategories.first,
                                             user: user)}

    before do
      ApplicationController.any_instance.stub(:authenticate_user!).and_return(true)
      ApplicationController.any_instance.stub(:current_user).and_return(user)
    end

    describe 'opportunities index page' do
      it 'shows correct auctions' do
        get :opportunities_index
        expect(response.status).to eq(200)
        expect(response.body).to have_content(auction_with_category.description)
        expect(response.body).to have_content(auction_with_subcats.description)
        expect(response.body).to_not have_content(auction_owner.description)
        expect(response.body).to_not have_content(auction_with_wrong_category.description)
      end
    end

    describe 'opportunities show page' do
      it 'shows correct auction' do
        get :show_opportunity, id: auction_with_category.id
        expect(response.status).to eq(200)
        expect(response.body).to have_content(auction_with_category.description)
      end

      it 'returns 404 to incorrect auction' do
        expect { get :show_opportunity, id: auction_with_wrong_category.id }.to raise_error(ActionController::RoutingError)

      end
    end
  end
end
