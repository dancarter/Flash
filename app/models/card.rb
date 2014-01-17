class Card < ActiveRecord::Base
  include SuperMemo::SM2

  has_many :taggings,
    inverse_of: :card,
    dependent: :destroy
  has_many :tags,
    through: :taggings,
    inverse_of: :cards
  has_many :review_list_cards,
    dependent: :destroy
  has_many :review_lists,
    through: :review_list_cards,
    inverse_of: :cards
  belongs_to :user,
    inverse_of: :cards

  validates_presence_of :front
  validates_presence_of :back
  validates_presence_of :user

  paginates_per 20
end
