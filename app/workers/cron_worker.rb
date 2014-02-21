class CronWorker
  include Sidekiq::Worker

  def perform
    # TODO: find task per level and create if it does not exists
    time = Time.now - last_task.created_at
    minutes_passed = time/60

    generate_new_task if minutes_passed > 5
  end

  def generate_new_task
    levels = [1,2,3,4,5]
    levels.each do |level|
      users = User.find_by(level: level)
      TaskCreator.perform_async(level) unless users.nil?
    end
  end
end
