class SendTaskToUsers
  include Sidekiq::Worker
  sidekiq_options retry: false, backtrace: true

  def perform(task_id)
    task = Task.find(task_id)
    users = User.where(level: task.level).order('random()').not_winners

    users.each { |u| TaskSender.perform_async(u.id, task.id) }
  end
end
