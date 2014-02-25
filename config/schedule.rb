every 2.minutes do
  runner "CronWorker.perform_async"
end
