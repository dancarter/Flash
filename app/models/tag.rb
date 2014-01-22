class Tag < ActiveRecord::Base
  has_many :taggings,
    inverse_of: :tag,
    dependent: :destroy
  has_many :cards,
    through: :taggings,
    inverse_of: :tags
  has_many :review_list_tags,
    dependent: :destroy
  has_many :review_lists,
    through: :review_list_tags,
    inverse_of: :tags
  belongs_to :user,
    inverse_of: :tags

  validates_presence_of :name
  validates_presence_of :user
  validates_presence_of :share_count

  paginates_per 10

  def avg_quality
    quality = 0
    count = 0
    self.cards.each do |card|
      if card.quality_of_last_recall
        quality += card.quality_of_last_recall
        count += 1
      end
    end
    return quality / count if count > 0
    0
  end

  def to_csv
    CSV.generate do |csv|
      csv << ['front','back','tags']
      self.cards.each do |card|
        attributes = card.attributes.values_at(*['front','back'])
        attributes << self.name
        csv << attributes
      end
    end
  end
end
