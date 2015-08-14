every 30.minute do
  runner "CollectActivitiesJob.perform_now"
end
