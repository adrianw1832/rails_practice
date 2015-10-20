require 'rails_helper'

feature 'review' do
  let!(:restaurant) { create(:restaurant) }

  scenario 'allow users to leave review using a form' do
    visit restaurants_path
    click_link 'Review Fat Duck'
    fill_in 'Thoughts', with: 'amazing'
    select '5', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq restaurant_path(restaurant)
    expect(page).to have_content 'amazing'
  end
end
