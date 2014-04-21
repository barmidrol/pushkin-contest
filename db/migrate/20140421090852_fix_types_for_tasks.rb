class FixTypesForTasks < ActiveRecord::Migration
  def change
    change_column :tasks, :question, :text
    change_column :tasks, :answer, :text
  end
end
