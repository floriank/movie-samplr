class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :name
      t.string :imdb_id, null: false
      t.integer :user_id, null: false
      t.text :notes
      t.timestamps null: false
    end

    create_table :lists_movies do |t|
      t.integer :list_id
      t.integer :movie_id
    end

    add_index :lists_movies, :movie_id
    add_index :lists_movies, :list_id
  end
end
