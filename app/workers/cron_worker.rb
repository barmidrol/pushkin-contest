class CronWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { secondly(10) }

  def perform
    (1..5).to_a.each do |level|
      p "CronWorker for level #{level} was started"
      task = TaskCreator::Factory.factory(level).create

      SendTaskToUsers.perform_at(5.seconds.from_now, task.id)
    end
  end
end
