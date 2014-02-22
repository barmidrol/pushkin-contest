class TaskCreator::Level5 < TaskCreator::Base

  def generate_task
    str = Poem.random_poem.content.split("\n").sample.gsub(/^\u00A0*/,"")
    correct_word = str.split(" ").sample
    correct_word = correct_word.gsub(/[[:punct:]]$|\u2014/,"")
    question = str
    str = Poem.random_poem.content.split("\n").sample
    wrong_word = str.split(" ").sample
    wrong_word = wrong_word.gsub(/[[:punct:]]$|\u2014/,"")
    question = question.gsub(correct_word, wrong_word)
    answer = "#{correct_word} #{wrong_word}"

    @task.question = question
    @task.answer = answer
  end

  def level
    5
  end
end
