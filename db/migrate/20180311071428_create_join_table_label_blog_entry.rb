class CreateJoinTableLabelBlogEntry < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_blog_entries_labels do |t|
      t.belongs_to :blog_entry
      t.belongs_to :label
    end
  end
end
