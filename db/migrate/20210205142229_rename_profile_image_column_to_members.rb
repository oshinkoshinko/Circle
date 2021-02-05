class RenameProfileImageColumnToMembers < ActiveRecord::Migration[5.2]
  def change
    rename_column :members, :profile_image, :profile_image_id
  end
end
