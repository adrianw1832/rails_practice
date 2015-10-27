require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurants' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    let!(:restaurant) { create(:restaurant) }

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content 'Fat Duck'
      expect(page).not_to have_content 'No restaurants yet'
    end
  end

  context 'creating restaurants' do
    let(:user) { create(:user) }

    context 'user is logged in' do
      scenario 'prompts user to fill in a form, then displays the restaurant' do
        sign_in_as(user)
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'Fat Duck'
        click_button 'Create Restaurant'
        expect(current_path).to eq '/restaurants'
        expect(page).to have_content 'Fat Duck'
      end
    end

    context 'user is not logged in' do
      scenario 'redirects user to log in page' do
        visit new_restaurant_path
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content 'Email'
        expect(page).to have_content 'Password'
      end
    end

    scenario 'does not allow user to submit a name that is too short' do
      sign_in_as(user)
      visit restaurants_path
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'Fa'
      click_button 'Create Restaurant'
      expect(page).not_to have_css 'h2', text: 'Fa'
      expect(page).to have_content 'error'
    end
  end

  context 'viewing restaurants' do
    let!(:restaurant) { create(:restaurant) }

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'Fat Duck'
      expect(page).to have_content 'Fat Duck'
      expect(current_path).to eq "/restaurants/#{restaurant.id}"
    end
  end

  context 'editing restaurants' do
    let(:user) { create(:user) }
    let(:user2) { create(:user, email: 'test2@test.com') }
    let!(:restaurant) { create(:restaurant, user: user) }

    context 'user is logged in' do
      scenario 'lets only the original user edit a restaurant' do
        sign_in_as(user)
        visit '/restaurants'
        click_link 'Edit Fat Duck'
        fill_in 'Name', with: 'Waterside Inn'
        click_button 'Update Restaurant'
        expect(page).to have_content 'Waterside Inn'
        expect(current_path).to eq '/restaurants'
      end

      scenario 'does not allow other users to edit a restaurant' do
        sign_in_as(user2)
        visit restaurants_path
        click_link 'Edit Fat Duck'
        expect(current_path).to eq restaurants_path
        expect(page).to have_content "Error! You can't edit this restaurant!"
      end
    end

    context 'user is not logged in' do
      scenario 'redirects user to log in page' do
        visit edit_restaurant_path(restaurant)
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content 'Email'
        expect(page).to have_content 'Password'
      end
    end
  end

  context 'deleting restaurants' do
    let(:user) { create(:user) }
    let(:user2) { create(:user, email: 'test2@test.com') }
    let!(:restaurant) { create(:restaurant, user: user) }

    context 'user is logged in' do
      scenario 'removes a restaurant when the creator clicks a delete link' do
        sign_in_as(user)
        visit restaurants_path
        click_link 'Delete Fat Duck'
        expect(page).not_to have_content 'Fat Duck'
        expect(page).to have_content 'Restaurant deleted successfully'
      end

      scenario 'does not allow other users to delete a restaurant' do
        sign_in_as(user2)
        visit restaurants_path
        click_link 'Delete Fat Duck'
        expect(current_path).to eq restaurants_path
        expect(page).to have_content "Error! You can't delete this restaurant!"
      end
    end

    context 'user is not logged in' do
      scenario 'redirects user to log in page' do
        visit restaurants_path
        click_link 'Delete Fat Duck'
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content 'Email'
        expect(page).to have_content 'Password'
      end
    end
  end
end
