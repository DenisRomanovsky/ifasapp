require 'rails_helper'

RSpec.feature 'Logged in user experience with NO js tests', :type => :feature do
  let!(:category_one) { FactoryGirl.create(:mechanism_category, :with_subcats) }
  let!(:category_two) { FactoryGirl.create(:mechanism_category, :with_subcats) }
  let!(:user) { FactoryGirl.create(:user) }

  before do
    ApplicationController.any_instance.stub(:authenticate_user!).and_return(true)
    ApplicationController.any_instance.stub(:current_user).and_return(user)
    DatabaseCleaner.strategy = :truncation
    Capybara.current_driver = :selenium
  end

  it 'can open new page' do
    DatabaseCleaner.start
    visit '/'
    click_link(category_one.home_description)
    expect(page).to have_content 'Создать аукцион для аренды техники.'
    DatabaseCleaner.clean
  end

  it 'can save auction' do
    DatabaseCleaner.start
    visit "/arenda/#{category_one.slug}"
    fill_in('Описание', with: Faker::Lorem.paragraph)

    accept_alert do
      click_button('Сохранить')
    end

    expect(page).to have_content 'Аукцион создан.'
    DatabaseCleaner.clean
  end
end
