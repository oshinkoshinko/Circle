class RenameRateColumnToEventMembers < ActiveRecord::Migration[5.2]
  def change
    rename_column :event_members, :rate, :score
  end
end
