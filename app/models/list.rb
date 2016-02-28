# A list represents a collection of movies for a user
# A user can have n ists containing m movies.
class List < ActiveRecord::Base
  belongs_to :user
  has_many :movies

  validates :user, presence: true
  validates :name, presence: true, length: { minimum: 5 }

  def self.default
    find_or_initialize_by(default: true)
  end
end
