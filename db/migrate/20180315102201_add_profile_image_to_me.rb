class AddProfileImageToMe < ActiveRecord::Migration[5.1]
  def up
    add_attachment :spree_mes, :profile_image
  end
  def down
    remove_attachment :spree_mes, :profile_image
  end
end
