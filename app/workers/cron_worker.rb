class CronWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { secondly(5) }

  def perform
    (1..8).to_a.each do |level|
      task = TaskCreator::Factory.factory(level).create

      raise "Task is not saved: #{task.to_s}" if task.id.blank?

      SendTaskToUsers.perform_at(1.seconds.from_now, task.id)
    end
  end
end
