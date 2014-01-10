class ReviewListTag < ActiveRecord::Base
  belongs_to :review_list
  belongs_to :tag

  validates_presence_of :tag
  validates_presence_of :review_list
end
