class TaskCreator::Base

  WORD_STUB="%WORD%".freeze

  attr_reader :task

  class << self
    def level(number)
      raise ArgumentErorr unless number.is_a?(Fixnum) || number > 0
      @level = number
    end

    def level_number
      @level
    end

  end


  def initialize
    @task = Task.new(level: self.class.level_number)
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

  def words_to_answer(words)
    words.map {|word| word.mb_chars.downcase.to_s }.join(',')
  end

  def pick_word(string)
    words = string.split(/\s/)
    strip_punctuation words.sample
  end
  alias_method :pick_words, :pick_word

  def pick_line(string, number=1)
    lines = string.split("\n")
    start =  lines.size >= number ? rand(0..lines.size-number) : 0
    lines[start...start+number]
  end
  alias_method :pick_lines, :pick_line

  def strip_punctuation(string)
    string.strip.gsub(/[[:punct:]]\z/, '')
  end

end
