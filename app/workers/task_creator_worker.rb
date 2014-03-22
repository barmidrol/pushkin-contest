class TaskCreatorWorker
  include Sidekiq::Worker

  def perform(level)
    p "TaskCreator for level #{level} was started"
    task = TaskCreator::Factory.factory(level).create
    SendTaskToUsers.perform_async(task.id)
  end

end
