class AddVisiblePublishedatAndSummaryToBlogEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_blog_entries, :visible, :boolean, :default => false
    add_column :spree_blog_entries, :published_at, :datetime
    add_column :spree_blog_entries, :summary, :text
  end
end
