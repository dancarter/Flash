class Tagging < ActiveRecord::Base
  belongs_to :card,
    inverse_of: :taggings
  belongs_to :tag,
    counter_cache: true,
    inverse_of: :taggings

  validates_presence_of :tag
  validates_presence_of :card

  validates_uniqueness_of :card_id,
    scope: :tag_id
end
