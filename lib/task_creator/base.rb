class TaskCreator::Base

  WORD_STUB="%WORD%".freeze

  attr_reader :task

  def initialize
    @task = Task.new(level: level)
  end

  def create
    generate_task
    save_task
    @task
  end

  def save_task
    @task.save
  end

  def generate_task
    raise NotImplementedError
  end

  def level
    raise NotImplementedError
  end

  def pick_word(string, number=1)
    binding.pry
  end
  alias_method :pick_words, :pick_word

  def pick_line(string, number=1)
    lines = string.split("\n")
    start =  lines.size <= number ? rand(0..lines.size-number) : 0
    lines[start..start+number]
  end
  alias_method :pick_lines, :pick_line

  def strip_punctuation_in_the_end(string)
    string.strip.gsub(/[[:punct:]]\z/, '')
  end

end
