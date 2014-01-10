class ReviewListCard < ActiveRecord::Base
  belongs_to :review_list,
    inverse_of: :review_list_cards
  belongs_to :card,
    inverse_of: :review_list_cards

  validates_presence_of :card
  validates_presence_of :review_list
end
