class RemoveIsFinishedFromEvents < ActiveRecord::Migration[5.2]
  def up
    remove_column :events, :is_finished
  end

  def down
    add_column :events, :is_finished, :boolean
  end

end
