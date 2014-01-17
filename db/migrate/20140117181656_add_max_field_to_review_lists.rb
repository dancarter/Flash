class AddMaxFieldToReviewLists < ActiveRecord::Migration

  def up
    add_column :review_lists, :max, :integer
  end

  def down
    remove_column :review_lists, :max
  end

end
