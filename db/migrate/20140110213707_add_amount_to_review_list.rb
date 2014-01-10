class AddAmountToReviewList < ActiveRecord::Migration
  def up
    add_column :review_lists, :amount, :integer, null: false
  end

  def down
    remove_column :review_lists, :amount
  end
end
