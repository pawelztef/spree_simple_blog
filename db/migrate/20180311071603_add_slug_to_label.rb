class AddSlugToLabel < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_labels, :slug, :string
  end
end
