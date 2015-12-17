class CollectActivitiesJob < ActiveJob::Base
  queue_as :default

  def perform(user_token)
    StravaFetcher.new(user_token).fetch_activities
  end
end
