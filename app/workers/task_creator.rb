class TaskCreator
  include Sidekiq::Worker

  def perform(level)
    creator = Task::Creator::Factory.factory(level)
    task = creator.create
    SendTaskToUsers.perform_async(task.id)
  end

end
