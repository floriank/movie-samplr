class Movie < ActiveRecord::Base
  has_and_belongs_to_many :lists
  belongs_to :user

  validates :name, presence: true
  validates :imdb_id, presence: true

  belongs_to :dataset, foreign_key: :imdb_id

  scope :by, ->(user) { where user: user }
end
