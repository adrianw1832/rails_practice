require 'spec_helper'

describe Review, type: :model do
  it { is_expected.to belong_to :restaurant }

  it { is_expected.to belong_to :user }

  it { is_expected.to have_many(:endorsements).dependent(:destroy) }

  it 'enforces uniqueness of user' do
    expect(create(:review)).to validate_uniqueness_of(:user)
  end

  let(:restaurant) { create(:restaurant) }
  it 'is invalid if the rating is more than 5' do
    review = restaurant.reviews.create(rating: 10)
    expect(review).to have(1).error_on(:rating)
    expect(review).to be_invalid
  end
end
