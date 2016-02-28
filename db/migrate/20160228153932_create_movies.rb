class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :name
      t.text :notes
      t.timestamps null: false
    end

    create_table :movies_lists do |t|
      t.integer :movie_id
      t.integer :list_id
    end

    add_index :movies_lists, :movie_id
    add_index :movies_lists, :list_id
  end
end
