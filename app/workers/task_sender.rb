class TaskSender
  include Sidekiq::Worker

  RESPONSE_TIME = 1.seconds.freeze

  def perform(user_id, task_id)
    #logger = Logger.new('log/task_sender')

    user = User.find(user_id)
    task = Task.find(task_id)

    uri = URI.parse("#{user.url}/quiz")

    puts "TaskSender user #{user_id} task #{task_id}".red
    puts "#{uri}".red

    request = Net::HTTP::Post.new(uri)
    request.set_form_data(task_id: task.id, question: task.question, task_level: task.level)
    response = Net::HTTP.start(uri.hostname, uri.port, read_timeout: RESPONSE_TIME) do |http|
      http.request(request)
    end

    puts "#{response}".red
  end

end
