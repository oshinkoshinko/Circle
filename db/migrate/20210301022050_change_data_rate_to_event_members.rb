class ChangeDataRateToEventMembers < ActiveRecord::Migration[5.2]
  def change
    change_column :event_members, :rate, :decimal, precision: 5, scale: 3
  end
end
