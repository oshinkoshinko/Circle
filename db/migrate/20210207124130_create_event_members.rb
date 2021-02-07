class CreateEventMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :event_members do |t|
      t.integer :event_id
      t.integer :member_id
      t.string :feedback
      t.integer :rate

      t.timestamps
    end
  end
end
