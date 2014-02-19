every 10.minutes do
  runner "CronWorker.perform_async"
end