class TaskListener
  include Sidekiq::Worker

  def perform(task_id, answer, token)
    task, user = Task.find(task_id), User.find_by(token: token)

    if task.answer.downcase == answer.downcase
      ActiveRecord::Base.transaction do
        task.update_attributes answered: true, user_id: user_id
        rating = user.rating + 1
        user.update_attributes rating: rating
      end

      uri = URI.parse("#{user.url}/result")
      parameters = {result: "good job"}.to_json
      Net::HTTP.post_form(uri, parameters)
    else
      uri = URI.parse("#{user.url}/result")
      parameters = {result: "wrong answer"}.to_json
      Net::HTTP.post_form(uri, parameters)
    end
    TaskCreatorWorker.perform_async(task.level)
  end
end
