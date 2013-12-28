class Tagging < ActiveRecord::Base
  belongs_to :card,
    inverse_of: :taggings
  belongs_to :tag,
    inverse_of: :taggings

  validates_presence_of :tag_id
  validates_presence_of :card_id
end
