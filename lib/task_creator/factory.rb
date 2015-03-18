class TaskCreator::Factory
  def self.factory(level)
    case level
    when 1 then TaskCreator::Level1.new
    when 2 then TaskCreator::Level2.new
    when 3 then TaskCreator::Level3.new
    when 4 then TaskCreator::Level4.new
    when 5 then TaskCreator::Level5.new
    when 6 then TaskCreator::Level6.new
    when 7 then TaskCreator::Level7.new
    when 8 then TaskCreator::Level8.new
    end
  end
end
