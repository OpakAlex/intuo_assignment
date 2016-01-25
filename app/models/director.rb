class Director < ActiveRecord::Base
  has_many :movie_directors, dependent: :destroy
  has_many :movies, through: :movie_directors
end
