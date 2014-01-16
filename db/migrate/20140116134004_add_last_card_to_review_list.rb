class AddLastCardToReviewList < ActiveRecord::Migration

  def up
    add_column :review_lists, :last_card, :integer
  end

  def down
    remove_column :review_lists, :last_card
  end

end
