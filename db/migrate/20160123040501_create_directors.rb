class CreateDirectors < ActiveRecord::Migration
  def change
    create_table :directors do |t|
      t.string :name
      t.timestamps null: false
    end
    add_index :directors, :name
  end
end
