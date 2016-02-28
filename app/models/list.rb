# A list represents a collection of movies for a user
# A user can have n ists containing m movies.
class List < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :movies

  validates :user, presence: true
  validates :name, presence: true, length: { minimum: 5 }

  scope :for, ->(user) { where user: user }

  def self.default
    find_or_initialize_by(default: true)
  end
end
