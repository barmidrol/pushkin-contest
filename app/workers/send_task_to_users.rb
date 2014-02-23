class SendTaskToUsers
  include Sidekiq::Worker

  def perform(id_task)
    task = Task.find_by id: id_task
    users = User.where(level: task.level)

    users.each { |user| TaskSender.perform_async(user.id, id_task) }
  end
end
