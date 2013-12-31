class Tag < ActiveRecord::Base
  has_many :taggings,
    inverse_of: :tag,
    dependent: :destroy
  has_many :cards,
    through: :taggings,
    inverse_of: :tags
  belongs_to :user,
    inverse_of: :tags

  validates_presence_of :name
  validates_presence_of :user_id

  def self.select_array
    Tag.all.collect {|p| [ p.name, p.id ] }
  end
end
