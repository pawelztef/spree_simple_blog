class AddEmailFieldToMe < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_mes, :email, :string
  end
end
