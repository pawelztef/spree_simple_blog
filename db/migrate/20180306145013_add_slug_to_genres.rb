class AddSlugToGenres < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_genres, :slug, :string
  end
end
