require 'spec_helper'

describe Restaurant, type: :model do
  it { is_expected.to have_many(:reviews).dependent(:destroy) }

  it 'is invalid with a name of less than three characters' do
    restaurant = Restaurant.new(name: 'Fa')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).to be_invalid
  end

  it 'is invalid if the name is not unique' do
    Restaurant.create(name: 'Fat Duck')
    restaurant = Restaurant.new(name: 'Fat Duck')
    expect(restaurant).to have(1).error_on(:name)
  end
end
