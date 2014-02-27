class TaskCreator::Level4 < TaskCreator::Base

  level 4

  def generate_task
    poem = Poem.random.first

    lines = pick_lines poem.content, 3
    words = lines.map {|line| pick_word(line) }
    question = words.map.with_index { |word, index| lines[index].gsub(word, WORD_STUB) }.join("\n")

    @task.question = question
    @task.answer = words_to_answer(words)
    @task.poem_id = poem.id
  end

end
