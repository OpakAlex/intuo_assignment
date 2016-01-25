class Movie < ActiveRecord::Base
  has_many :movie_members, dependent: :destroy
  has_many :members, through: :movie_members
  has_many :movie_directors, dependent: :destroy
  has_many :directors, through: :movie_directors


  def create_members(raw_members = [])
    ids = raw_members.map do |member|
      Member.where(name: member).first_or_create.id
    end
    self.member_ids = ids 
  end

  def create_directors(raw_directors = [])
    ids = raw_directors.map do |director|
      Director.where(name: director).first_or_create.id
    end
    self.director_ids = ids 
  end
end
