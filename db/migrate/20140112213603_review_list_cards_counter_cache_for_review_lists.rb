class ReviewListCardsCounterCacheForReviewLists < ActiveRecord::Migration

  def up
    add_column :review_lists, :review_list_cards_count, :integer, default: 0
    add_index :review_lists, :review_list_cards_count
  end

  def down
    remove_column :review_lists, :review_list_cards_count
  end

end
