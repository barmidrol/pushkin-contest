class TaskCreator::Level6 < TaskCreator::Base

  level 6

  def generate_task
    poem = Poem.random.first

    words = strip_punctuation(poem.content).split(/ /)

    @task.question = words.map { |word| randomize_word(word) }.join(' ')
    @task.answer = poem.content
    @task.poem_id = poem.id
  end

  def randomize_word(word)
    word.split(//).shuffle.join
  end

  def random_word
    @random_word ||= generate_random_word
  end

end
