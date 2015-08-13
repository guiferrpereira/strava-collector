every 1.minute do
  runner "CollectActivitiesJob.perform_now"
end
