class TaskCreator::Level4 < TaskCreator::Base

  def generate_task
    poem = Poem.order('random()').limit(3)
    str = poem.map { |p| p.content.split("\n").sample(1).join }
    answer = str.map { |s| s.split(" ").sample }
    answer = answer.map { |a| a.gsub(/[[:punct:]]$|\u2014/,"") }
    question = str.each_with_index.map { |s, i| s.gsub(answer[i], "%WORD%") }
    question = question.map { |q| q.gsub(/^\u00A0*/,"")}

    @task.question = question.join(" %NEWLINE% ")
    @task.answer = answer.join(" ")
  end

  def level
    4
  end
end
