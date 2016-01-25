class Member < ActiveRecord::Base
  has_many :movie_members, dependent: :destroy
  has_many :movies, through: :movie_members
end
