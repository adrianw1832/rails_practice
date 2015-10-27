require 'spec_helper'

describe Restaurant, type: :model do
  let(:user) { create(:user) }
  let(:user2) { create(:user, email: 'test2@test.com') }
  let(:restaurant) { create(:restaurant, user: user) }

  it { is_expected.to have_many(:reviews).dependent(:destroy) }

  it { is_expected.to belong_to(:user) }

  it 'is invalid with a name of less than three characters' do
    restaurant = user.restaurants.new(name: 'Fa')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).to be_invalid
  end

  it 'is invalid if the name is not unique' do
    user.restaurants.create(name: 'Fat Duck')
    restaurant = user.restaurants.new(name: 'Fat Duck')
    expect(restaurant).to have(1).error_on(:name)
  end

  context 'creating restaurants' do
    it 'is valid if it belongs to a user' do
      restaurant = user.restaurants.create(name: 'Fat Duck')
      expect(restaurant).to be_valid
    end

    it 'is invalid if it does not belong to a user' do
      restaurant = Restaurant.create(name: 'Fat Duck')
      expect(restaurant).to be_invalid
    end
  end

  context 'deleting restaurants' do
    it 'can be deleted by its creator' do
      restaurant.destroy_as_user(user)
      expect(Restaurant.first).to be nil
    end

    it 'cannot be deleted by someone else' do
      restaurant.destroy_as_user(user2)
      expect(Restaurant.first).to eq restaurant
    end
  end
end
