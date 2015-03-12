class AddMoreInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :surname,:string, null: false
    add_column :users, :skype, :string, null: false
    add_column :users, :github, :string, null: false
    add_column :users, :phone, :string, null: false
    add_column :users, :vk, :string, null: false
  end
end
