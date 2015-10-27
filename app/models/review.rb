class Review < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :user

  validates_uniqueness_of :user
  # validates :user, uniqueness: { scope: :restaurant, message: "has reviewed this restaurant already" }
  validates :rating, inclusion: (1..5)
end
