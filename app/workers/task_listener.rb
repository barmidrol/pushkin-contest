class TaskListener
  include Sidekiq::Worker

  def perform(task_id, user_id, answer)
    task, user = Task.find(task_id), User.find(user_id)

    if task.answer.downcase == answer.downcase
      ActiveRecord::Base.transaction do
        task.update_attributes answered: true, user_id: user_id
        rating = user.rating + 1
        user.update_attributes rating: rating
      end
    end
    TaskCreator.perform_async(task.level)
  end
end
