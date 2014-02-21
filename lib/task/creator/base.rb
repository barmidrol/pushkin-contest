class Task::Creator::Base

  attr_reader :task

  def initialize
    @task = Task.new(level: level)
  end

  def create
    generate_task
    save_task
  end

  def save_task
    @task.save
  end

  def random_poem
    @random_poem ||= Poem.random_poem
  end

  def generate_task
    raise NotImplementedError
  end

  def level
    raise NotImplementedError
  end

  # def level2
  #   task = Task.new
  #   # user receive string from poem with one missed word and need to answer right word
  #   str = .content.split("\n").sample
  #   answer = str.split(" ").sample
  #   answer = answer.gsub(/[[:punct:]]|\u2014/,"")
  #   question = str.sub(answer, "%WORD%")
  # end

  # def level34 level
  #   task = Task.new
  #   # 2 or 3 strings and 2 or 3 words in response separated by spaces
  #   poem = Poem.order('random()').limit(level-1)
  #   str = poem.map { |p| p.content.split("\n").sample(1).join }
  #   answer = str.map { |s| s.split(" ").sample }
  #   answer = answer.map { |a| a.gsub(/[[:punct:]]|\u2014/,"") }
  #   question = str.each_with_index.map { |s, i| s.gsub(answer[i], "%WORD%") }

  #   task.question = question.join(" %NEWLINE% ")
  #   task.answer = answer.join(" ")
  #   task.level = level-1
  #   task.save
  # end

  # def level5
  #   task = Task.new
  #   # string with changed word. Answer is wrong_word correct_word separated by spaces
  #   str = Poem.random_poem.content.split("\n").sample
  #   correct_word = str.split(" ").sample
  #   correct_word = correct_word.gsub(/[[:punct:]]|\u2014/,"")
  #   question = str
  #   str = Poem.random_poem.content.split("\n").sample
  #   wrong_word = str.split(" ").sample
  #   wrong_word = wrong_word.gsub(/[[:punct:]]|\u2014/,"")
  #   question = question.gsub(correct_word, wrong_word)
  #   answer = "#{correct_word} #{wrong_word}"

  #   task.question = question
  #   task.answer = answer
  #   task.level = 5
  #   task.save
  # end

end
