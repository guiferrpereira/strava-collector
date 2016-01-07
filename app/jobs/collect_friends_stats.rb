class CollectFriendsStats < ActiveJob::Base
  queue_as :default

  def perform(user_token)
    StravaFetcher.new(user_token).fetch_stats
  end
end
