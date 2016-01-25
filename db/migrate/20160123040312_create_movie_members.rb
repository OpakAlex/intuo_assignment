class CreateMovieMembers < ActiveRecord::Migration
  def change
    create_table :movie_members do |t|
      t.references :movie
      t.references :member
      t.timestamps null: false
    end
    add_index :movie_members, :movie_id
    add_index :movie_members, :member_id
  end
end
