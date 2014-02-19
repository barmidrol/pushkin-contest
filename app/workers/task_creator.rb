class TaskCreator
  include Sidekiq::Worker

  def perform(level)
    task = Task.new

    case level
    when 1
      # user receive string from poem and need to answer poem's title
      poem = Poem.all.sample(1).first
      question = poem.content.split("\n").sample
      answer = poem.title

      task.question = question
      task.answer = answer
      task.level = 1
    when 2
      # user receive string from poem with one missed word and need to answer right word
      str = Poem.all.sample(1).first.content.split("\n").sample
      answer = str.split(" ").sample
      answer = answer.gsub(/[[:punct:]]|\u2014/,"")
      question = str.sub(answer, "%WORD%")

      task.question = question
      task.answer = answer
      task.level = 2
    when 3, 4
      # 2 or 3 strings and 2 or 3 words in response
      poem = Poem.all.sample n-1
      str = poem.map { |p| p.content.split("\n").sample(1).join }
      answer = str.map { |s| s.split(" ").sample }
      answer = answer.map { |a| a.gsub(/[[:punct:]]|\u2014/,"") }
      question = str.each_with_index.map { |s, i| s.gsub(answer[i], "%WORD%") }

      task.question = question.join(" %NEWLINE% ")
      task.answer = answer.join(" ")
      task.level = n-1
    when 5
      # string with changed word. Answer is {"wrong_word" => "correct_word"}
      str = Poem.all.sample(1).first.content.split("\n").sample
      correct_word = str.split(" ").sample
      correct_word = correct_word.gsub(/[[:punct:]]|\u2014/,"")
      question = str
      str = Poem.all.sample(1).first.content.split("\n").sample
      wrong_word = str.split(" ").sample
      wrong_word = wrong_word.gsub(/[[:punct:]]|\u2014/,"")
      question = question.gsub(correct_word, wrong_word)
      answer = "#{correct_word} #{wrong_word}"

      task.question = question
      task.answer = answer
      task.level = 5
    end

    task.save
    
    id = Task.last.id
  end
end
