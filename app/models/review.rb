class Review < ActiveRecord::Base
  include AsUserAssociationExtensions

  belongs_to :restaurant
  belongs_to :user

  # validates_uniqueness_of :user
  validates :user, uniqueness: { scope: :restaurant }
  validates :rating, inclusion: (1..5)
end
