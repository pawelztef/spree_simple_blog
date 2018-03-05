class CreateJoinTableCategoryBlogEntry < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_blog_entries_categories do |t|
      t.belongs_to :blog_entry
      t.belongs_to :category
    end
  end
end
