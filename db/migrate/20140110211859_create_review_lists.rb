class CreateReviewLists < ActiveRecord::Migration
  def change
    create_table :review_lists do |t|

      t.timestamps
    end
  end
end
