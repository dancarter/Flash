class AddSrsFieldsToReviewLists < ActiveRecord::Migration
  def change
    add_column :review_lists, :srs_review, :boolean
    add_column :review_lists, :new_count, :integer
  end
end
