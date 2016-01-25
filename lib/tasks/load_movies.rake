task :load_movies => :environment do
  movies = Imdb::Top250.new.movies rescue []
  movies.each do |movie|
    movie_record = Movie.where(fk: movie.id).first_or_create
    update_movie(movie, movie_record)
    parse_members(movie, movie_record)
    parse_directors(movie, movie_record)
  end
end

def update_movie(movie, movie_record)
  movie_record.url = movie.url
  movie_record.rating = movie.rating
  movie_record.title = movie.title
  movie_record.save
end

def parse_members(movie, movie_record)
  members = movie.cast_members
  movie_record.create_members(members)
end

def parse_directors(movie, movie_record)
  directors = movie.director
  movie_record.create_directors(directors)
end
