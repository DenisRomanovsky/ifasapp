require 'rails_helper'

RSpec.feature 'Logged in user experience with NO js tests', :type => :feature do
  let!(:category_one) { FactoryGirl.create(:mechanism_category, :with_subcats) }
  let!(:category_two) { FactoryGirl.create(:mechanism_category, :with_subcats) }
  let!(:category_three) { FactoryGirl.create(:mechanism_category, :with_subcats) }
  let!(:user) { FactoryGirl.create(:user) }

  before do
    ApplicationController.any_instance.stub(:authenticate_user!).and_return(true)
    ApplicationController.any_instance.stub(:current_user).and_return(user)
  end

  it 'can open new page' do
    visit '/'
    click_link(category_one.home_description)
    expect(page).to have_content 'Создать аукцион для аренды техники.'
  end

  describe 'Auction successful creation' do
    it 'can save auction' do
      description = Faker::Lorem.paragraph

      visit "/arenda/#{category_one.slug}"
      fill_in('Описание', with: description)
      page.check 'Ставки с учётом стоимости доставки'
      click_button('Сохранить')

      expect(page).to have_content 'Аукцион создан.'
      auction = Auction.first

      expect(auction.description).to eq(description)
      expect(auction.mechanism_category_id).to eq(category_one.id)
      expect(auction.user_id).to eq(user.id)
      expect(auction.end_time - auction.start_time).to be_between(1195, 1205)

      expect(auction.cash_payed).to eq(true)
      expect(auction.delivery_included).to eq(true)
      expect(auction.with_tax).to eq(false)
      expect(auction.user_email).to eq(nil)
    end

    describe 'Mailing' do
      let!(:user_with_tech_one) do
        user = FactoryGirl.create(:user)
        FactoryGirl.create(:mechanism, user: user, mechanism_category: category_one, mechanism_subcategory: category_one.mechanism_subcategories.first)
        user
      end

      let!(:user_with_tech_two)do
        user = FactoryGirl.create(:user)
        FactoryGirl.create(:mechanism, user: user, mechanism_category: category_one, mechanism_subcategory: category_one.mechanism_subcategories.last)
        user
      end

      let!(:user_with_tech_three)do
        user = FactoryGirl.create(:user)
        FactoryGirl.create(:mechanism, user: user, mechanism_category: category_two, mechanism_subcategory: category_two.mechanism_subcategories.last)
        user
      end

      describe 'When only category selected' do
        it 'sends correct emails to bidders' do
          visit "/arenda/#{category_one.slug}"
          fill_in('Описание', with: Faker::Lorem.paragraph)
          click_button('Сохранить')

          expect(ActionMailer::Base.deliveries.size).to eq(2)
          expect(ActionMailer::Base.deliveries.first.body).to have_content("Новый аукцион в категории #{category_one.description}")
        end

        it 'sends correct emails when no matches' do
          visit "/arenda/#{category_three.slug}"
          fill_in('Описание', with: Faker::Lorem.paragraph)
          click_button('Сохранить')
          expect(ActionMailer::Base.deliveries.size).to eq(0)
        end

        it 'sends correct emails when several matches per one user' do
          FactoryGirl.create(:mechanism, user: user_with_tech_one, mechanism_category: category_one, mechanism_subcategory: category_one.mechanism_subcategories.first)
          FactoryGirl.create(:mechanism, user: user_with_tech_one, mechanism_category: category_one, mechanism_subcategory: category_one.mechanism_subcategories[1])

          visit "/arenda/#{category_one.slug}"
          fill_in('Описание', with: Faker::Lorem.paragraph)
          click_button('Сохранить')
          expect(ActionMailer::Base.deliveries.size).to eq(2)
        end
      end

      describe 'When subcategories selected' do
        it 'sends correct emails when one match in subcats' do
          visit "/arenda/#{category_one.slug}"
          fill_in('Описание', with: Faker::Lorem.paragraph)
          select(category_one.mechanism_subcategories.first.description, from: 'auction_auction_subcategories')
          click_button('Сохранить')

          expect(ActionMailer::Base.deliveries.size).to eq(1)
        end

        it 'sends correct emails when several matches in subcats' do
          FactoryGirl.create(:mechanism, user: user_with_tech_one, mechanism_category: category_one, mechanism_subcategory: category_one.mechanism_subcategories.last)

          visit "/arenda/#{category_one.slug}"
          fill_in('Описание', with: Faker::Lorem.paragraph)
          select(category_one.mechanism_subcategories.first.description, from: 'auction_auction_subcategories')
          select(category_one.mechanism_subcategories.last.description, from: 'auction_auction_subcategories')

          click_button('Сохранить')
          expect(ActionMailer::Base.deliveries.size).to eq(2)
        end


        it 'sends correct emails when no match in subcats' do
          visit "/arenda/#{category_one.slug}"
          fill_in('Описание', with: Faker::Lorem.paragraph)
          select(category_one.mechanism_subcategories[1].description, from: 'auction_auction_subcategories')
          click_button('Сохранить')

          expect(ActionMailer::Base.deliveries.size).to eq(0)
        end
      end
    end
  end

  describe 'Show page' do
    let!(:user_with_tech_one) do
      user = FactoryGirl.create(:user)
      FactoryGirl.create(:mechanism, user: user, mechanism_category: category_one, mechanism_subcategory: category_one.mechanism_subcategories.first)
      user
    end

    let!(:user_with_tech_two)do
      user = FactoryGirl.create(:user)
      FactoryGirl.create(:mechanism, user: user, mechanism_category: category_one, mechanism_subcategory: category_one.mechanism_subcategories.last)
      user
    end

    let!(:auction) { FactoryGirl.create(:auction, :with_subcats, user_id: user.id) }

    describe 'Auction with no bids' do
      it 'shows no bids correctly' do
        expect(Auction.all.size).to eq(1)

        visit '/auctions'
        click_link 'Детали'

        expect(page).to have_content 'Здесь пока ничего нет.'
      end

      it 'shows auction data' do
        visit "/auctions/#{auction.id}/"

        expect(page).to have_content auction.description
        expect(page).to have_content auction.mechanism_category.description
        expect(page).to have_content auction.mechanism_subcategories.first.description
        expect(page).to have_content 'Да'

        expect(page).to have_content 'Включена в цену'
        expect(page).to have_content (auction.end_time.utc + 3.hours).strftime("%d/%m/%Y %R")
      end

      it 'blocks not owner from show page' do
        ApplicationController.any_instance.stub(:current_user).and_return(user_with_tech_two)
        expect{visit "/auctions/#{auction.id}/"}.to raise_error(ActionController::RoutingError)
      end
    end

    describe 'Auction with bids' do
      let!(:bid_one) { FactoryGirl.create(:bid, user_id: user_with_tech_one.id, mechanism_id: user_with_tech_one.mechanisms.first.id, auction_id: auction.id) }
      let!(:bid_two) { FactoryGirl.create(:bid, user_id: user_with_tech_two.id, mechanism_id: user_with_tech_two.mechanisms.first.id, auction_id: auction.id) }

      it 'shows correctly bids' do
        visit "/auctions/#{auction.id}/"

        expect(page).to have_content bid_one.price
        expect(page).to have_content bid_two.price
        expect(page).to have_content bid_one.description
        expect(page).to have_content bid_two.description
      end

      it 'shows only active bids' do
        bid_three = FactoryGirl.create(:bid, user_id: user_with_tech_two.id, mechanism_id: user_with_tech_two.mechanisms.first.id, auction_id: auction.id)
        bid_two.update_attribute(:status, :archived)

        visit "/auctions/#{auction.id}/"

        expect(page).not_to have_content bid_two.description
        expect(page).not_to have_content bid_two.price
        expect(page).to have_content bid_three.price
        expect(page).to have_content bid_three.description
      end
    end
  end
end
