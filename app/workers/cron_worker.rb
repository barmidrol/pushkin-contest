class CronWorker
  include Sidekiq::Worker

  def perform
    levels = [1,2,3,4,5]
    tasks = levels.map { |l| Task.where(level: l).last }

    puts "CronWorker".red

    tasks.each do |t|
      puts "task #{t.id} level #{t.level} answered #{t.answered}".red
      levels.delete(t.level) unless t.nil?
    end

    tasks.each do |t|
      if t.nil?
        l = levels.first
        TaskCreatorWorker.perform_async(l)
        levels.delete(l)
      end

      if t.answered
        puts "create task level #{t.level}".red
        TaskCreatorWorker.perform_async(t.level)
      end

      if !t.answered and (Time.now - t.created_at)/60 > 5
        t.update_attribute(:answered, true)
        TaskCreatorWorker.perform_async(t.level)
      end
    end
  end
end
