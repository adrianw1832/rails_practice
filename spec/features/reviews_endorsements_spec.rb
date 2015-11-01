require 'rails_helper'

feature 'Reviews endorsements' do
  let(:user) { create(:user) }
  let(:restaurant) { create(:restaurant, user: user) }
  let!(:review) { create(:review, restaurant: restaurant) }

  scenario 'a user can endorse a review, which updates the review endorsement count' do
    sign_in_as(user)
    visit restaurant_path(restaurant)
    click_link 'Endorse review'
    expect(page).to have_content '1 endorsement'
  end
end
