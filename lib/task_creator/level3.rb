class TaskCreator::Level3 < TaskCreator::Base

  def generate_task
    poem = Poem.order('random()').limit(2)
    str = poem.map { |p| p.content.split("\n").sample(1).join }
    answer = str.map { |s| s.split(" ").sample }
    answer = answer.map { |a| a.gsub(/[[:punct:]]$|\u2014/,"") }
    question = str.each_with_index.map { |s, i| s.gsub(answer[i], "%WORD%") }
    question = question.map { |q| q.gsub(/^\u00A0*/,"")}

    @task.question = question.join(" %NEWLINE% ")
    @task.answer = answer.join(" ")
    @task.poem_id = poem.first.id
  end

  def level
    3
  end
end
