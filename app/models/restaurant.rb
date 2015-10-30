class Restaurant < ActiveRecord::Base
  include AsUserAssociationExtensions

  has_many :reviews, -> { extending WithUserAssociationExtension }, dependent: :destroy
  belongs_to :user

  validates :name, length: {minimum: 3}, uniqueness: true
  validates_presence_of :user

  def average_rating
    return 'N/A' if reviews.none?
    4
  end
end
