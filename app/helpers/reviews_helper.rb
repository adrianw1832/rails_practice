module ReviewsHelper
  def star_rating(rating)
    return rating unless rating.respond_to?(:round)
    remainder = 5 - rating
    '★' * rating.round + "☆" * remainder
  end

  def created_since(review)
    current_time = Time.now
    time_difference = (current_time - review.created_at).floor
    'Created ' + pluralize(time_difference, 'hour') + ' ago'
  end
end
