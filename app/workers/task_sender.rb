class TaskSender
  include Sidekiq::Worker

  def perform(id_user, id_task)
    user = User.find_by id: id_user
    task = Task.find_by id: id_task

    uri = URI.parse(user.url)
    parameters = {id: task.id, question: task.question, level: task.level}.to_json
    response = Net::HTTP.post_form(uri, parameters)

    puts "Task sender".red
    puts response.message.to_s.red
  end
end
