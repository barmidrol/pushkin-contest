class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :question
      t.string :answer
      t.boolean :answered, default: false
      t.integer :level
      t.integer :user_id

      t.timestamps
    end
  end
end
