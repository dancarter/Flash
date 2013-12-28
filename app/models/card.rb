class Card < ActiveRecord::Base
  validates_presence_of :front
  validates_presence_of :back
  validates_presence_of :user_id
end
