class SendTaskToUsers
  include Sidekiq::Worker

  def perform(id_task)
    task = Task.find_by id: id_task
    need_rating = task.level * 50
    users = User.all.where("rating >= ?", need_rating)

    users.each { |user| TaskSender.perform_async(user.id, id_task) }
  end
end
