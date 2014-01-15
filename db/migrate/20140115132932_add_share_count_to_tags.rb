class AddShareCountToTags < ActiveRecord::Migration

  def up
    add_column :tags, :share_count, :integer, null: false, default: 0
  end

  def down
    remove_column :tags, :share_count
  end

end
