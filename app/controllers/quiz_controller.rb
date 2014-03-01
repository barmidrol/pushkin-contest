class QuizController < ApplicationController
  helper_method :quiz_answer_request
  respond_to :json

  skip_before_filter :verify_authenticity_token, :only => [:answer]



  def answer
    if quiz_answer_request.invalid?
      render json: { errors: quiz_answer_request.errors.full_messages }
      return
    end

    TaskListener.perform_async(task.id, answer, params[:token])
  end

  def quiz_answer_request
    @quiz_answer_request ||= QuizAnswerRequest.new(request_params)
  end

  def request_params
    params.slice(:token, :task_id, :answer)
  end

end
