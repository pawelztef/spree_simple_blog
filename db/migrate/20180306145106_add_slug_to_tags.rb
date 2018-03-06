class AddSlugToTags < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_tags, :slug, :string
  end
end
