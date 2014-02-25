class TaskListener
  include Sidekiq::Worker

  def perform(task_id, answer, token)
    task, user = Task.find(task_id), User.find_by(token: token)

    puts "TaskListener".red
    puts "task #{task_id} use #{user.id}".red
    puts "#{answer}".red

    if task.answer.downcase == answer.downcase.force_encoding("UTF-8")
      ActiveRecord::Base.transaction do
        task.update_attributes answered: true, user_id: user.id
        rating = user.rating + 1
        user.update_attributes rating: rating
      end

      uri = URI.parse("#{user.url}/result")
      parameters = {result: "good job"}
      Net::HTTP.post_form(uri, parameters)
    else
      uri = URI.parse("#{user.url}/result")
      parameters = {result: "wrong answer"}
      Net::HTTP.post_form(uri, parameters)

      ActiveRecord::Base.transaction do
        rating = user.rating - 1
        user.update_attributes rating: rating
      end
    end
    TaskCreatorWorker.perform_async(task.level)
  end
end
