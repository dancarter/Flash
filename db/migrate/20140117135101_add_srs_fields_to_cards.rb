class AddSrsFieldsToCards < ActiveRecord::Migration
  def up
    add_column :cards, :easiness_factor, :decimal, default: 2.5
    add_column :cards, :number_repetitions, :integer, default: 0
    add_column :cards, :quality_of_last_recall, :integer
    add_column :cards, :next_repetition, :date
    add_column :cards, :repetition_interval, :integer
    add_column :cards, :last_studied, :date
  end

  def down
    remove_column :cards, :easiness_factor
    remove_column :cards, :number_repetitions
    remove_column :cards, :quality_of_last_recall
    remove_column :cards, :next_repetition
    remove_column :cards, :repetition_interval
    remove_column :cards, :last_studied
  end
end
