class CreateJoinTableGenreBlogEntry < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_blog_entries_genres do |t|
      t.belongs_to :blog_entry
      t.belongs_to :genre
    end
  end
end
