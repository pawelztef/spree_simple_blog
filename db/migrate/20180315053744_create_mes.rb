class CreateMes < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_mes do |t|
      t.string :fullname
      t.string :phone
      t.string :address_line1
      t.string :address_line2
      t.string :address_line3
      t.text :bio

      t.timestamps
    end
  end
end
