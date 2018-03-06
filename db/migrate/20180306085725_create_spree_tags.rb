class CreateSpreeTags < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_tags do |t|
      t.string :name

      t.timestamps
    end
  end
end
