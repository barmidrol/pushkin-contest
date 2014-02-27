class TaskCreator::Level2 < TaskCreator::Base

  level 2

  def generate_task
    poem = Poem.random.first

    line = strip_punctuation pick_line(poem.content).first
    word = pick_word(line)

    @task.answer = words_to_answer([word])
    @task.question = line.gsub(word, WORD_STUB)
    @task.poem_id = poem.id
  end

end
