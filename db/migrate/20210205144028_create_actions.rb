class CreateActions < ActiveRecord::Migration[5.2]
  def change
    create_table :actions do |t|
      t.integer :member_id
      t.integer :genre_id
      t.string :body

      t.timestamps
    end
  end
end
