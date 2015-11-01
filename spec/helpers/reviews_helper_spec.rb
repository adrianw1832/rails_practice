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
  end
end
