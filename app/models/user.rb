class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :cards,
    inverse_of: :user,
    dependent: :destroy
  has_many :tags,
    inverse_of: :user,
    dependent: :destroy

  validates_presence_of :username

  validates_uniqueness_of :username
end
