class TaskCreatorWorker
  include Sidekiq::Worker

  def perform(level)
    creator = TaskCreator::Factory.factory(level)
    task = creator.new.create
    SendTaskToUsers.perform_async(task.id)
  end

end
