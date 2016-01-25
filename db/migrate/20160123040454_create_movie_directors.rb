class CreateMovieDirectors < ActiveRecord::Migration
  def change
    create_table :movie_directors do |t|
      t.references :movie
      t.references :director
      t.timestamps null: false
    end

    add_index :movie_directors, :movie_id
    add_index :movie_directors, :director_id
  end
end
