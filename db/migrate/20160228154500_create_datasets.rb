class CreateDatasets < ActiveRecord::Migration
  def change
    create_table :datasets do |t|
      t.string :title, null: false
      t.string :plot
      t.text :plot_summary
      t.string :poster_url
      t.string :tagline
      t.integer :year, null: false
      t.string :imdb_id, null: false
      t.timestamps null: false
    end

    add_column :datasets, :cast, :text, array: true, default: []
    add_column :datasets, :director, :text, array: true, default: []

    add_index :datasets, :imdb_id
  end
end
