class CronWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  # recurrence { minutely(2) }
  recurrence { secondly }

  def perform
    levels = [1,2,3,4,5]
    tasks = levels.map { |l| Task.where(level: l).last }.compact

    Task.where(answered: false).where('created_at < ?', 5.seconds.ago).each do |task|
      task.update_attribute(:answered, true)
    end

    levels.each do |level|
      count = Task.where(level: level, answered: false).count
      p "Unanswered tasks for level #{level} = #{count}"

      if count.zero?
        TaskCreatorWorker.perform_async(level)
        p "TaskCreator for level #{level} was started"
      end
    end
  end
end
