class TaskCreator::Level7 < TaskCreator::Base

  level 7

  def generate_task
    poem = Poem.random.first

    text = strip_punctuation(poem.content)

    @task.question = text.split(//).shuffle.join
    @task.answer = text
    @task.poem_id = poem.id
  end

end
