class AddShareAttributeToTags < ActiveRecord::Migration

  def up
    add_column :tags, :share, :boolean, default: false
  end

  def down
    remove_column :tags, :share
  end

end
