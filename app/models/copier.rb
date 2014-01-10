class Copier

  def self.copy_tag_to(tag, user)
    tag_dup = tag.dup
    tag_dup.taggings_count = 0
    user.tags << tag_dup
    copy_cards_for_tag(tag, tag_dup)
    tag_dup
  end

  def self.copy_cards_for_tag(old_tag, new_tag)
    old_tag.cards.each do |card|
      duplicate = card.dup
      new_tag.user.cards << duplicate
      new_tag.cards << duplicate
    end
    new_tag.cards
  end
end
