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
    scenario 'prompts user to fill in a form, then displays the restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'Fat Duck'
      click_button 'Create Restaurant'
      expect(current_path).to eq '/restaurants'
      expect(page).to have_content 'Fat Duck'
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
    let!(:restaurant) { create(:restaurant) }

    scenario 'let a user edit a restaurant' do
      visit '/restaurants'
      click_link 'Edit Fat Duck'
      fill_in 'Name', with: 'Waterside Inn'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Waterside Inn'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'deleting restaurants' do
    let!(:restaurant) { create(:restaurant) }

    scenario 'removes a restaurant when user clicks a delete link' do
      visit restaurants_path
      click_link 'Delete Fat Duck'
      expect(page).not_to have_content 'Fat Duck'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end
end
