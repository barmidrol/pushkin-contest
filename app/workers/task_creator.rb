class TaskCreator
  include Sidekiq::Worker

  def perform(level)
    case level
    when 1
      level1
    when 2
      level2
    when 3, 4
      level34 level
    when 5
      level5
    else
      level1
    end

    id_task = Task.last.id # ATTENTION! I'm not sure that we can receive saved task. Maybe transaction is still working...
    SendTaskToUsers.perform_async(id_task) # send this new task to all users with matching level
    TaskChecker.delay_for(5.minutes, :retry => false).perform_async(id_task) # generate new task in 5 minutes if unsolved
  end

  def level1
    task = Task.new
    # user receive string from poem and need to answer poem's title
    poem = Poem.random_poem
    question = poem.content.split("\n").sample
    answer = poem.title

    task.question = question
    task.answer = answer
    task.level = 1
    task.save
  end

  def level2
    task = Task.new
    # user receive string from poem with one missed word and need to answer right word
    str = Poem.random_poem.content.split("\n").sample
    answer = str.split(" ").sample
    answer = answer.gsub(/[[:punct:]]|\u2014/,"")
    question = str.sub(answer, "%WORD%")

    task.question = question
    task.answer = answer
    task.level = 2
    task.save
  end

  def level34 level
    task = Task.new
    # 2 or 3 strings and 2 or 3 words in response separated by spaces
    poem = Poem.order('random()').limit(level-1)
    str = poem.map { |p| p.content.split("\n").sample(1).join }
    answer = str.map { |s| s.split(" ").sample }
    answer = answer.map { |a| a.gsub(/[[:punct:]]|\u2014/,"") }
    question = str.each_with_index.map { |s, i| s.gsub(answer[i], "%WORD%") }

    task.question = question.join(" %NEWLINE% ")
    task.answer = answer.join(" ")
    task.level = level-1
    task.save
  end

  def level5
    task = Task.new
    # string with changed word. Answer is wrong_word correct_word separated by spaces
    str = Poem.random_poem.content.split("\n").sample
    correct_word = str.split(" ").sample
    correct_word = correct_word.gsub(/[[:punct:]]|\u2014/,"")
    question = str
    str = Poem.random_poem.content.split("\n").sample
    wrong_word = str.split(" ").sample
    wrong_word = wrong_word.gsub(/[[:punct:]]|\u2014/,"")
    question = question.gsub(correct_word, wrong_word)
    answer = "#{correct_word} #{wrong_word}"

    task.question = question
    task.answer = answer
    task.level = 5
    task.save
  end
end
