# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Logged in user experience with NO js tests', type: :feature do
  before do
    ApplicationController.any_instance.stub(:authenticate_user!).and_return(true)
    ApplicationController.any_instance.stub(:current_user).and_return(user)
    Capybara.javascript_driver = :poltergeist
  end

  describe 'Auction successful creation' do
    let!(:category_one) { FactoryGirl.create(:mechanism_category, :with_subcats) }
    let!(:category_two) { FactoryGirl.create(:mechanism_category, :with_subcats) }
    let!(:user) { FactoryGirl.create(:user) }

    it 'can open new page' do
      visit '/'
      click_button('Начать аукцион!')
      click_link(category_one.description)
      expect(page).to have_content 'Создать аукцион для аренды техники.'
    end

    it 'can save auction' do
      visit "/arenda/#{category_one.slug}"
      fill_in('Описание', with: Faker::Lorem.paragraph)

      click_button('Сохранить')
      expect(page).to have_content 'Аукцион создан.'
    end
  end
end
