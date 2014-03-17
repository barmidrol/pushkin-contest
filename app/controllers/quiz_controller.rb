class QuizController < ApplicationController
  helper_method :quiz_answer_request
  respond_to :json

  skip_before_filter :verify_authenticity_token, :only => [:answer]

  def answer
    if quiz_answer_request.invalid?
      render json: { errors: quiz_answer_request.errors.full_messages }, status: :error
      return
    end

    if @task.answer.downcase.strip == @answer.downcase.strip
      ActiveRecord::Base.transaction do
        task.update_attributes answered: true, user_id: user.id
        user.update_attributes rating: user.rating + 1
      end
      TaskCreatorWorker.perform_in(30.seconds, task.level)
      message = 'Correct'
    else
      message = 'Wrong'
    end

    render json: { message: message }, status: :ok
  end

  def user
    @user||= quiz_answer_request.user
  end

  def task
    @task ||= quiz_answer_request.task
  end

  def answer
    @answer ||= quiz_answer_request.answer
  end

  def quiz_answer_request
    @quiz_answer_request ||= QuizAnswerRequest.new(request_params)
  end

  def request_params
    params.slice(:token, :task_id, :answer)
  end

end
