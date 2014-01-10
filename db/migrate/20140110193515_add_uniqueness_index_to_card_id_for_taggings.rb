class AddUniquenessIndexToCardIdForTaggings < ActiveRecord::Migration
  def up
    add_index :taggings, [:card_id, :tag_id], unique: true
  end

  def down
    remove_index :taggings, [:card_id, :tag_id]
  end
end
