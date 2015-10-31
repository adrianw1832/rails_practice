require 'rails_helper'

feature 'review' do
  let(:user) { create(:user) }
  let(:user2) { create(:user, email: 'test2@test.com') }
  let!(:restaurant) { create(:restaurant, user: user) }

  context 'when user are signed in' do
    scenario 'allow users to leave review using a form' do
      sign_in_as(user)
      leave_review('amazing', '5')
      expect(current_path).to eq restaurant_path(restaurant)
      expect(page).to have_content 'amazing'
    end

    scenario 'allow users to only leave one review' do
      sign_in_as(user)
      leave_review('amazing', '5')
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

  context 'user is logged in' do
    before do
      sign_in_as(user)
      leave_review('amazing', '5')
      click_link 'Sign out'
    end

    scenario 'removes the review when the creator clicks the delete link' do
      sign_in_as(user)
      visit restaurants_path
      click_link 'Fat Duck'
      click_link 'Delete review'
      expect(page).not_to have_content 'amazing'
      expect(page).to have_link 'Review Fat Duck'
    end

    scenario 'does not allow other users to delete a restaurant' do
      sign_in_as(user2)
      visit restaurants_path
      click_link 'Fat Duck'
      expect(page).not_to have_link 'Delete review'
    end
  end

  context 'average rating' do
    scenario 'displays an average rating for all reviews' do
      sign_in_as(user)
      leave_review('so so', '3')
      click_link 'Sign out'
      sign_in_as(user2)
      leave_review('great', '5')
      visit restaurants_path
      expect(page).to have_content('Average rating: 4')
    end
  end
end
