class RemoveIsFinishedFromEvents < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :is_finished, :boolean
  end
end
