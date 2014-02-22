class TaskCreator::Level1 < TaskCreator::Base

  def generate_task
    question = Poem.random_poem.content.split("\n").sample
    question = question.gsub(/^\u00A0*/,"")
    @task.question = question
    @task.answer = Poem.random_poem.title
  end

  def level
    1
  end
end
