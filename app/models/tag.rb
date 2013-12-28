class Tag < ActiveRecord::Base
  has_many :taggings,
    inverse_of: :tag,
    dependent: :destroy

  validates_presence_of :name
  validates_presence_of :user_id
end
