class CreateReviewListTags < ActiveRecord::Migration
  def change
    create_table :review_list_tags do |t|
      t.integer :review_list_id, null: false
      t.integer :tag_id, null: false

      t.timestamps
    end
  end
end
