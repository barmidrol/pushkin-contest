class TaskCreator::Level6 < TaskCreator::Base

  level 6

  def generate_task
    poem = Poem.random.first

    line = pick_line(poem.content)

    text = strip_punctuation(line)

    words = text.split(/ /)

    @task.question = words.map { |word| randomize_word(word) }.join(' ')
    @task.answer = text
    @task.poem_id = poem.id
  end

  def randomize_word(word)
    word.split(//).shuffle.join
  end

end
