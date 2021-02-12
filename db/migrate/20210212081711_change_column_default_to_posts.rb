class ChangeColumnDefaultToPosts < ActiveRecord::Migration[5.2]
  def change
    change_column_default :posts, :address, from: nil, to: "日本"
  end
end
