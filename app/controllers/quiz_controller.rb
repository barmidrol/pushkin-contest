class QuizController < ApplicationController
  def answer
    # user have to send answer, task id and his own unique token
    task_id = params[:id]
    answer = params[:answer]
    token = params[:token]

    TaskListener.perform_async(task_id, answer, token)
  end
end
