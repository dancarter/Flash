class ReviewListCard < ActiveRecord::Base
  belongs_to :review_list
  belongs_to :card

  validates_presence_of :card
  validates_presence_of :review_list
end
