class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :card_id, null: false
      t.integer :tag_id, null: false

      t.timestamps
    end
  end
end
