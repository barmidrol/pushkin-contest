class TaskCreator::Level7 < TaskCreator::Base

  level 7

  def generate_task
    poem = Poem.random.first

    line = pick_line(poem.content).first

    text = strip_punctuation(line)

    @task.question = text.split(//).shuffle.join
    @task.answer = text
    @task.poem_id = poem.id
  end

end
