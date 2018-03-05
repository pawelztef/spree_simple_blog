class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
