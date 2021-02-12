class RemoveDefaultRestrictFromPosts < ActiveRecord::Migration[5.2]
  def change
    change_column_default :posts, :address, from: "日本", to: nil
  end
end
