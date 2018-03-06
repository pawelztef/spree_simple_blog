class CreateJoinTableTagBlogEntry < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_blog_entries_tags do |t|
      t.belongs_to :blog_entry
      t.belongs_to :tag
    end
  end
end
