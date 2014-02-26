class TaskCreator::Level1 < TaskCreator::Base

  def generate_task
    poem = Poem.where("title NOT ILIKE ?", '%*%').random.first
    line = pick_line poem.content
    line = strip_punctuation_in_the_end

    @task.question = line
    @task.answer = poem.title
    @task.poem_id = poem.id
  end

  def level
    1
  end
end
