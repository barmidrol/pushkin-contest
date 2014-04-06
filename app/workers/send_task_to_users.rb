class SendTaskToUsers
  include Sidekiq::Worker

  def perform(task_id)
    task = Task.find(task_id)
    users = User.where(level: task.level)

    p "TaskSender for level #{task.level} has #{users.count} users"
    users.each do |u|
      TaskSender.perform_async(u.id, task.id)
      p "TaskSender to user #{u.id}  with #{u.url} was started"
    end
  end
end
