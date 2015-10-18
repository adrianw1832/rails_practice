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
end
