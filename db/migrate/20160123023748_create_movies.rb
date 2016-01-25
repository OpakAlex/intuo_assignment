class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :fk
      t.float :rating
      t.text :description
      t.string :url
      t.timestamps null: false
    end

    add_index :movies, :fk
    add_index :movies, :title
    add_index :movies, :rating
  end
end
