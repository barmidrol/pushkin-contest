class AddPoemIdToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :poem_id, :integer
    Task.reset_column_information
  end
end
