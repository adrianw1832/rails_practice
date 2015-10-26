class Restaurant < ActiveRecord::Base
  include AsUserAssociationExtensions

  has_many :reviews, dependent: :destroy
  belongs_to :user

  validates :name, length: {minimum: 3}, uniqueness: true
  validates_presence_of :user
end
