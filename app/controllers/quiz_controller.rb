class QuizController < ApplicationController
  def answer
    task = Task.where(id: params[:task_id], answered: false).first
    answer = params[:answer]
    user = User.find_by(token: params[:token])

    unless user
      return #?
    end

    if task.solved
      uri = URI.parse("#{user.url}/result")
      parameters = {result: "task is already solved"}.to_json
      Net::HTTP.post_form(uri, parameters)
    end

    TaskListener.perform_async(task_id, answer, token)

    #render :error, status: :error
  end
end
