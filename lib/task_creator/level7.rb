class TaskCreator::Level7 < TaskCreator::Base

  level 7

  def generate_task
    poem = Poem.random.first

    line = pick_line(poem.content).first

    text = line.split(//).reject { |s| s =~ /[[:punct:]]/ }.join

    @task.question = text.split(//).shuffle.join
    @task.answer = text
    @task.poem_id = poem.id
  end

end
