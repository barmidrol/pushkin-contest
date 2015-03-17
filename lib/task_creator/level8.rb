class TaskCreator::Level8 < TaskCreator::Base

  level 8

  def generate_task
    poem = Poem.random.first

    text = strip_punctuation(poem.content)
    shuffled = text.split(//).shuffle

    shuffled[rand(0..shuffled.size-1)] = random_symbol

    @task.question = shuffled.join
    @task.answer = text
    @task.poem_id = poem.id
  end

  def random_symbol
    @random_symbol ||= generate_random_symbol
  end

  protected

  def generate_random_symbol
    poem = Poem.random.first
    line = pick_line(poem.content).first
    pick_word(line).split(//).sample
  end


end
