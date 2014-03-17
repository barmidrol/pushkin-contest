class SendTaskToUsers
  include Sidekiq::Worker

  def perform(task_id)
    task = Task.find(task_id)
    users = User.where(level: task.level)

    users.each { |u| TaskSender.perform_async(u.id, task.id) }
  end
end
