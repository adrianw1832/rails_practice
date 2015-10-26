require 'spec_helper'

describe Restaurant, type: :model do
  let(:user) { create(:user) }

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

  it 'is valid if it belongs to a user' do
    restaurant = user.restaurants.create(name: 'Fat Duck')
    expect(restaurant).to be_valid
  end

  it 'is invalid if it does not belong to a user' do
    restaurant = Restaurant.create(name: 'Fat Duck')
    expect(restaurant).to be_invalid
  end
end
