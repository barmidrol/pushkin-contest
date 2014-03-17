class TaskCreatorWorker
  include Sidekiq::Worker

  def perform(level)
    task = TaskCreator::Factory.factory(level).create
    SendTaskToUsers.perform_in(5.seconds, task.id)
  end

end
