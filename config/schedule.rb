every 12.hour do
  runner "CollectActivitiesJob.perform_now"
end
