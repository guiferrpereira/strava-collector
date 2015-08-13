class CollectActivitiesJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    StravaFetcher.new.fetch_activities
  end
end
