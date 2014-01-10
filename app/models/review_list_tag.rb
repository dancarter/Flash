class ReviewListTag < ActiveRecord::Base
  belongs_to :review_list,
    inverse_of: :review_list_tags
  belongs_to :tag,
    inverse_of: :review_list_tags

  validates_presence_of :tag
  validates_presence_of :review_list
end
