class Task::Creator::Level1 < Task::Creator::Base

  def generate_task
    @task.question = random_poem.content.split("\n").sample
    @task.answer = random_poem.title
  end

  def level
    1
  end
end
