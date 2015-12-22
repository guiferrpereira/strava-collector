class CollectFriendsJob < ActiveJob::Base
  queue_as :default

  def perform(user_token, user_id)
    StravaFetcher.new(user_token).fetch_friends(user_id)
  end
end
