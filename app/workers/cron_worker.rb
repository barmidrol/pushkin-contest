class CronWorker
  include Sidekiq::Worker

  def perform
    levels = [1,2,3,4,5]
    tasks = levels.map { |l| Task.where(level: l).last }

    tasks.each do |t|
      TaskCreator.perform_async(t.level) if t.nil? or t.answered
      if !t.answered and (Time.now - t.created_at)/60 > 5
        t.answered = true
        TaskCreator.perform_async(t.level)
      end
    end
  end
end
