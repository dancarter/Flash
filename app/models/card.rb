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

  def self.to_csv
    CSV.generate do |csv|
      csv << ['front','back','tags']
      all.each do |card|
        attributes = card.attributes.values_at(*['front','back'])
        tags = card.tags.collect { |tag| tag.name }
        tags = tags.join(' ')
        attributes << tags
        csv << attributes
      end
    end
  end
end
