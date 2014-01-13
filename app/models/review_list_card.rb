class ReviewListCard < ActiveRecord::Base
  belongs_to :review_list,
    inverse_of: :review_list_cards,
    counter_cache: true
  belongs_to :card

  validates_presence_of :card
  validates_presence_of :review_list
end
