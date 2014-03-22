class SendTaskToUsers
  include Sidekiq::Worker

  def perform(task_id)
    p "TaskSender for task #{task_id} was started"
    task = Task.find(task_id)
    users = User.where(level: task.level)

    p "TaskSender has #{users.count} users"
    users.each do |u|
      TaskSender.perform_async(u.id, task.id)
      p "TaskSender to user #{u} was started"
    end
  end
end
