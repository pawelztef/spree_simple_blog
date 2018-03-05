class CreateJoinTableCategoryBlogEntry < ActiveRecord::Migration[5.1]
  def change
    create_join_table :categories, :blog_entries do |t|
      t.index [:category_id, :blog_entry_id]
      t.index [:blog_entry_id, :category_id]
    end
  end
end
