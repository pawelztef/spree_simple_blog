class CreateSpreeBlogTags < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_blog_tags do |t|
      t.string :name

      t.timestamps
    end
  end
end
