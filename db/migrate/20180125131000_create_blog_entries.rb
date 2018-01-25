class CreateBlogEntries < ActiveRecord::Migration[5.1]
  def self.up
    create_table :spree_blog_entries do |t|
      t.column :title, :string
      t.column :body, :text
      t.column :permalink, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :spree_blog_entries
  end

end
