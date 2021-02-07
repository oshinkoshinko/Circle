class AddIsFinishedToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :is_finished, :boolean, default: false, null: false
  end
end
