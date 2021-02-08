class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.integer :member_id
      t.integer :genre_id
      t.string :name
      t.string :content
      t.string :place
      t.string :event_image_id
      t.string :fee
      t.boolean :is_finished
      t.datetime :started_at
      t.datetime :finished_at
      t.datetime :expired_at

      t.timestamps
    end
  end
end
