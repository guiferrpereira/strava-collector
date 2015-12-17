class StravaFetcher
  def initialize user_token
    @strava_client ||= Strava::Api::V3::Client.new(access_token: user_token)
    @redis ||= Redis.new
  end

  def fetch_activities page=1
    activities = @strava_client.list_athlete_activities page: page

    return [] if activities.empty?
    
    activities.each  do |activity|
      if @redis.get "#{activity['athlete']['id']}-#{activity['id']}".present?
        break
      else
        @redis.set "#{activity['athlete']['id']}-#{activity['id']}", activity.to_json
      end
    end
    page += 1
    self.fetch_activities page
  end
end