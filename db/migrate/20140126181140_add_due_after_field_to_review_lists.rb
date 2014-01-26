class AddDueAfterFieldToReviewLists < ActiveRecord::Migration
  def up
    add_column :review_lists, :due_after, :date
  end

  def down
    remove_column :review_lists, :due_after
  end
end
