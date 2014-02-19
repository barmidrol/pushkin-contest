class QuizController < ApplicationController
  def answer
    # user have to send answer, task id and his own unique token
    task_id = params[:id]
    answer = params[:answer]
    token = params[:token]

    # now we need to need to make sure, that we have such user
    user = User.find_by token: token
    user_id = user.id

    # and such task
    task = task.find_by id: task_id

    # is task already solved?
    return if task.answered

    if task.answer.downcase == answer.downcase
      task.update_attributes answered: true, user_id: user_id
      rating = user.rating + 1
      user.update_attributes rating: rating

      TaskCreator.perform_async(task.level) # now we need to generate new task for current level
    end
  end
end
