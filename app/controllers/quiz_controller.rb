class QuizController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:answer]

  def answer
    task = Task.where(id: params[:task_id], answered: false).first
    answer = params[:answer]
    user = User.find_by(token: params[:token])

    unless user
      return #?
    end

    if task.answered
      uri = URI.parse("#{user.url}/result")
      parameters = {result: "task is already solved"}.to_json
      Net::HTTP.post_form(uri, parameters)
    end

    TaskListener.perform_async(task.id, answer, params[:token])

    #render :error, status: :error
  end
end
