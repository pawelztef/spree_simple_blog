class AddSlugToBlogTags < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_blog_tags, :slug, :string
  end
end
