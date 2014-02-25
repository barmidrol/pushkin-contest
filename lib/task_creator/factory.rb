class TaskCreator::Factory
  def self.factory(level)
    case level
    when 1 then TaskCreator::Level1
    when 2 then TaskCreator::Level2
    when 3 then TaskCreator::Level3
    when 4 then TaskCreator::Level4
    when 5 then TaskCreator::Level5
    end
  end
end
