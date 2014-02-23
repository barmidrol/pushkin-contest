class TaskCreatorWorker
  include Sidekiq::Worker

  def perform(level)
    puts "TaskCreator".red
    task = Task.where(level: level).last
    puts "task #{task.id} level #{task.level} answered = #{task.answered}".red
    if task.answered
      creator = TaskCreator::Factory.factory(level)
      task = creator.new.create
      SendTaskToUsers.perform_async(task.id)
      puts "task id = #{task.id}".red
    end
  end

end
