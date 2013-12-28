class Tagging < ActiveRecord::Base
  validates_presence_of :tag_id
  validates_presence_of :card_id
end
