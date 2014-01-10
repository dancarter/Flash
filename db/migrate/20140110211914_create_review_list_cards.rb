class CreateReviewListCards < ActiveRecord::Migration
  def change
    create_table :review_list_cards do |t|
      t.integer :review_list_id, null: false
      t.integer :card_id, null: false

      t.timestamps
    end
  end
end
