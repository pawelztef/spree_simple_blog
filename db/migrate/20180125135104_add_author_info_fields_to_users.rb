class AddAuthorInfoFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    change_table :spree_users do |t|
      t.string :nickname
      t.string :website_url
      t.string :google_plus_url
      t.text :bio_info
    end
  end
end
