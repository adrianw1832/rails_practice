class ReviewsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]
  before_action :enforce_single_review, only: [:create, :new]

  def new
    find_restaurant
    @review = Review.new
  end

  def create
    find_restaurant
    @review = @restaurant.reviews.build_with_user(review_params, current_user)
    redirect_to restaurant_path(@restaurant) if @review.save
  end

  def destroy
    find_restaurant
    @review = Review.find(params[:id])
    @review.destroy_as_user(current_user)
    redirect_to restaurant_path(@restaurant)
  end

  private

  def find_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

  def enforce_single_review
    find_restaurant
    if @restaurant.reviews.find_by(user_id: current_user).present?
      redirect_to restaurants_path
    end
  end
end
