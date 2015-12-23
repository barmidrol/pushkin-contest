class TaskSender
  include Sidekiq::Worker

  sidekiq_options retry: false, backtrace: true

  RESPONSE_IDLE_TIME = 1.seconds.freeze

  def perform(user_id, task_id)
    user, task = User.find(user_id), Task.find(task_id)

    uri = URI.parse(user.url)
    uri.path = '/quiz'
    data = {question: task.question, id: task.id, level: task.level}
    headers = { content_type: :json, accept: :json }

    retryable(tries: 3) do
      RestClient::Request.execute(method: :post, url: uri.to_s, payload: data.to_json, headers: headers, timeout: 2, open_timeout: 2)
    end
  end

end
