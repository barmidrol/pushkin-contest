class TaskCreator::Level1 < TaskCreator::Base

  level 1

  def generate_task
    poem = Poem.where("title NOT ILIKE ?", '%*%').random.first
    line = strip_punctuation pick_line(poem.content).first

    @task.question = line
    @task.answer = poem.title.downcase
    @task.poem_id = poem.id
  end

end
