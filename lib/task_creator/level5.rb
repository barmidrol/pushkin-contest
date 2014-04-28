class TaskCreator::Level5 < TaskCreator::Base

  level 5

  def generate_task
    poem = Poem.random.first

    line = strip_punctuation pick_line(poem.content).first
    word = pick_word(line)

    @task.question = line.sub(word, random_word)
    @task.answer = words_to_answer([word, random_word])
    @task.poem_id = poem.id
  end

  def random_word
    @random_word ||= generate_random_word
  end

  protected

  def generate_random_word
    poem = Poem.random.first
    line = pick_line(poem.content).first
    pick_word(line)
  end

end
