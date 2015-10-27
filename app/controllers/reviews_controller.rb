class ReviewsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.build_with_user(review_params, current_user)
    if @review.save
      redirect_to restaurant_path(@restaurant)
    else
      redirect_to restaurant_path(@restaurant)
      flash[:notice] = 'You have already reviewed this restaurant'
    end
  end

  private

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end
