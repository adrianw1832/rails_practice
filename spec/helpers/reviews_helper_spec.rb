require 'rails_helper'

describe ReviewsHelper, type: :helper do
  context '#star rating' do
    it 'displays nothing for non number' do
      expect(helper.star_rating('N/A')).to eq 'N/A'
    end

    it 'returns five black stars for five' do
      expect(helper.star_rating(5)).to eq '★★★★★'
    end

    it 'returns three black stars and two white stars for three' do
      expect(helper.star_rating(3)).to eq '★★★☆☆'
    end

    it 'returns four black stars and one white star for 3.4' do
      expect(helper.star_rating(3.5)).to eq '★★★★☆'
    end
  end

  context '#created_since' do
    it 'returns 0 hours for newly created reviews' do
      review = create(:review)
      expect(helper.created_since(review)).to eq 'Created 0 hours ago'
    end

    it 'returns 1 hour for reviews that have been created for an hour' do
      review = create(:review, created_at: (Time.now - 3600))
      expect(helper.created_since(review)).to eq 'Created 1 hour ago'
    end

    it 'returns 2 hour for reviews that have been created two hours ago' do
      review = create(:review, created_at: (Time.now - 7200))
      expect(helper.created_since(review)).to eq 'Created 2 hours ago'
    end
  end
end
