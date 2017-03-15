require 'rails_helper'

RSpec.feature 'Home page', :type => :feature do
  let!(:category) { FactoryGirl.create(:mechanism_category) }
  let!(:user) { FactoryGirl.create(FactoryGirl.create(:user)) }

  it 'home page is available' do
    visit '/'
    expect(page).to have_content 'Арендовать технику легко!'
  end

  it 'home page has a category' do
    visit '/'
    expect(page).to have_content category.home_description
  end
end
