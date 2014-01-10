class AssociateReviewListsWithUser < ActiveRecord::Migration

  def up
    add_column :review_lists, :user_id, :integer
  end

  def down
    remove_column :review_lists, :user_id
  end

end
