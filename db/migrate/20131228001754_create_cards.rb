class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.text :front, null: false
      t.text :back, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
