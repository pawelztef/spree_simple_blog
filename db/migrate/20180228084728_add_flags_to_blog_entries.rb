class AddFlagsToBlogEntries < ActiveRecord::Migration[5.1]
  def up
    add_column :spree_blog_entries, :project, :boolean
    add_column :spree_blog_entries, :slider, :boolean
  end
  def down
    remove_column :spree_blog_entries, :project, :boolean
    remove_column :spree_blog_entries, :slider, :boolean
  end
end
