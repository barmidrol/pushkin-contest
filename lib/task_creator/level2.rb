class TaskCreator::Level2 < TaskCreator::Base

  def generate_task
    poem = Poem.random.first

    str = poem.content.split("\n").sample.gsub(/^\u00A0*/,"")
    answer = str.split(" ").sample
    @task.answer = answer.gsub(/[[:punct:]]$|\u2014/,"")
    @task.question = str.sub(answer, "%WORD%")
    @task.poem_id = p.id
  end

  def level
    2
  end
end
