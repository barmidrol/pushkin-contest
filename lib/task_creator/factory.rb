class TaskCreator::Factory
  def self.factory(level)
    case level
    when 1 then TaskCreator::Level1.new
    when 2 then TaskCreator::Level2.new
    when 3 then TaskCreator::Level3.new
    when 4 then TaskCreator::Level4.new
    when 5 then TaskCreator::Level5.new
    end
  end
end
