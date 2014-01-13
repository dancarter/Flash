class ReviewListTag < ActiveRecord::Base
  belongs_to :review_list,
    inverse_of: :review_list_tags
  belongs_to :tag

  validates_presence_of :tag
  validates_presence_of :review_list
end
