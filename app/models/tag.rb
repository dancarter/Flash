class Tag < ActiveRecord::Base
  has_many :taggings,
    inverse_of: :tag,
    dependent: :destroy
  has_many :cards,
    through: :taggings,
    inverse_of: :tags
  has_many :review_list_tags,
    dependent: :destroy
  has_many :review_lists,
    through: :review_list_tags,
    inverse_of: :tags
  belongs_to :user,
    inverse_of: :tags

  validates_presence_of :name
  validates_presence_of :user
  validates_presence_of :share_count

  paginates_per 10
end
