class Task::Creator::Factory
  def self.factory(level)
    case level
    when 1 then Task::Creator::Level1
    when 2 then Task::Creator::Level2
    when 3 then Task::Creator::Level3
    when 4 then Task::Creator::Level4
    when 5 then Task::Creator::Level5
    end
  end
end
