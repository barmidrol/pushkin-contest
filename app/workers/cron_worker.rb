class CronWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { secondly(25) }

  def perform
    (1..5).to_a.each do |level|
      task = TaskCreator::Factory.factory(level).create

      raise "Task is not saved: #{task.to_s}" if task.id.blank?

      SendTaskToUsers.perform_at(5.seconds.from_now, task.id)
    end
  end
end
