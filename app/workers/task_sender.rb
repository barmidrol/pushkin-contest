class TaskSender
  include Sidekiq::Worker

  sidekiq_options retry: false, backtrace: true

  RESPONSE_IDLE_TIME = 1.seconds.freeze

  def perform(user_id, task_id)
    user, task = User.find(user_id), Task.find(task_id)

    uri = URI.parse(user.url)
    uri.path = '/quiz'
    data = {question: task.question, id: task.id, level: task.level}
    options = {content_type: :json, accept: :json, timeout: RESPONSE_IDLE_TIME}

    retryable(tries: 3) { RestClient.post(uri.to_s, data.to_json, options) }
  end

end
