class SendTaskToUsers
  include Sidekiq::Worker

  def perform(task_id)
    puts "SendTaskToUsers".red
    task = Task.find(task_id)
    puts "id #{task.id} level #{task.level} answer #{task.answer}".red

    users = User.where(level: task.level)

    users.each do |u|
      puts "user_id #{u.id}".red
      TaskSender.perform_async(u.id, task.id)
    end
  end
end
