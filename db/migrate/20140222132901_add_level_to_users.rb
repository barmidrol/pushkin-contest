class AddLevelToUsers < ActiveRecord::Migration
  def change
    add_column :users, :level, :integer
    User.reset_column_information
  end
end
