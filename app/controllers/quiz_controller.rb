class QuizController < ApplicationController
  def answer
    # user have to send answer, task id and his own unique token
    task = Task.where(id: params[:id], answered: false).first
    answer = params[:answer]
    user = User.find_by(token: params[:token])

    unless user
    end

    if task.solved
      uri = URI.parse(user.url + "/result")
      parameters = {result: "task is already solved"}.to_json
      Net::HTTP.post_form(uri, parameters)
    end

    # TODO: add check for user token
    # TODO: check for expired task

    # # now we need to need to make sure, that we have such user
    # user = User.find_by token: token
    # user_id = user.id

    # # and such task
    # task = task.find_by id: task_id

    # # is task already solved?

    TaskListener.perform_async(task_id, answer, token)

    #render :error, status: :error
  end
end
