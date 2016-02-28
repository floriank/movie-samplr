class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable, :recoverable, :rememberable, :validatable

  has_many :lists

  after_save :create_default_list!

  private

  def create_default_list!
    list = lists.default
    return if list.persisted?
    list.name = I18n.t('.lists.default_name')
    list.save
  end
end
