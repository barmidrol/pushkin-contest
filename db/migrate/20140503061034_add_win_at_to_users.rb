class AddWinAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :win_at, :datetime
  end
end
