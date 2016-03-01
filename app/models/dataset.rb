class Dataset < ActiveRecord::Base
  has_many :movies, foreign_key: :imdb_id, primary_key: :imdb_id
end
