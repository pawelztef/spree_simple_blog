class CreateSpreeLabels < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_labels do |t|
      t.string :name
      t.timestamps
    end
  end
end
