class TaskCreator::Level1 < TaskCreator::Base

  def generate_task
    p = Poem.random_poem
    question = p.content.split("\n").sample
    question = question.gsub(/^\u00A0*/,"")
    @task.question = question
    @task.answer = p.title
    @task.poem_id = p.id
  end

  def level
    1
  end
end
