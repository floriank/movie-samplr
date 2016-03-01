class Movie < ActiveRecord::Base
  # the maximum of movies displayed intiially for a list
  MAX_DISPLAY = 5

  has_and_belongs_to_many :lists
  belongs_to :user

  validates :name, presence: true
  validates :imdb_id, presence: true

  belongs_to :dataset, foreign_key: :imdb_id, primary_key: :imdb_id

  default_scope { order('updated_at DESC')}

  scope :by, ->(user) { where user: user }

end
