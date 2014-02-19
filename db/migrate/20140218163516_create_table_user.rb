class CreateTableUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :token, null: false
      t.string :url, null: false
      t.integer :rating, default: 0
      t.timestamps
    end
  end
end
