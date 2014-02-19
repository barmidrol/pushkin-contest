class TaskChecker
  include Sidekiq::Worker

  def perform(id_task)
    task = Task.find_by id: id_task
    solved = task.answered
    level = task.level
    
    TaskCreator.perform_async(level) unless solved
  end
end
