class EndorsementsController < ApplicationController
  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.find(params[:review_id])
    @review.endorsements.create
    redirect_to restaurant_path(@restaurant)
  end
end
