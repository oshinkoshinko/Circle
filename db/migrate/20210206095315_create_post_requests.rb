class CreatePostRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :post_requests do |t|
      t.integer :member_id
      t.integer :post_id
      t.boolean :is_requested, default: false, null: false
      t.boolean :is_accepted, default: false, null: false

      t.timestamps
    end
  end
end
