require 'rails_helper'

feature 'review' do
  let(:user) { create(:user) }
  let!(:restaurant) { create(:restaurant, user: user) }

  context 'when user are signed in' do
    scenario 'allow users to leave review using a form' do
      sign_in_as(user)
      visit restaurants_path
      click_link 'Fat Duck'
      click_link 'Review Fat Duck'
      fill_in 'Thoughts', with: 'amazing'
      select '5', from: 'Rating'
      click_button 'Leave Review'
      expect(current_path).to eq restaurant_path(restaurant)
      expect(page).to have_content 'amazing'
    end

    scenario 'allow users to only leave one review' do
      sign_in_as(user)
      visit restaurants_path
      click_link 'Fat Duck'
      click_link 'Review Fat Duck'
      fill_in 'Thoughts', with: 'amazing'
      select '5', from: 'Rating'
      click_button 'Leave Review'
      visit restaurants_path
      expect(page).not_to have_content 'Review Fat Duck'
      visit new_restaurant_review_path(restaurant)
      expect(current_path).to eq restaurants_path
    end
  end

  context 'when user is not signed in' do
    scenario 'does not allow user to leave a review' do
        visit restaurants_path
        click_link 'Fat Duck'
        click_link 'Review Fat Duck'
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content 'Email'
        expect(page).to have_content 'Password'
    end
  end
end
