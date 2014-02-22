class TaskCreator::Base

  attr_reader :task

  def initialize
    @task = Task.new(level: level)
  end

  def create
    generate_task
    save_task
    @task
  end

  def save_task
    @task.save
  end

  def generate_task
    raise NotImplementedError
  end

  def level
    raise NotImplementedError
  end

end
