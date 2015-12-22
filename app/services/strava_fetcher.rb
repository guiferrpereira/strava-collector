require 'net/http'

class StravaFetcher
  def initialize user_token
    @strava_client ||= Strava::Api::V3::Client.new(access_token: user_token)
    @redis ||= Redis.new
  end

  def fetch_activities page=1
    activities = @strava_client.list_athlete_activities page: page

    return [] if activities.empty?

    activities.each  do |activity|
      if @redis.get "activity-#{activity['athlete']['id']}-#{activity['id']}".present?
        break
      else
        @redis.set "activity-#{activity['athlete']['id']}-#{activity['id']}", activity.to_json
      end
    end
    page += 1
    self.fetch_activities page
  end

  def fetch_friends athlete_id
    friends = @strava_client.list_athlete_friends

    friends.each  do |friend|
      if @redis.get "friend-#{athlete_id}-#{friend['id']}".present?
        break
      else
        @redis.set "friend-#{athlete_id}-#{friend['id']}", friend.to_json
      end
    end
  end

  def fetch_stats
    friends = @strava_client.list_athlete_friends

    friends.each  do |friend|
      uri = URI("#{StravaCollector.config.strava_scraper[:url]}/#{friend['id']}")
      rsp = Net::HTTP.get_response(uri)
      @redis.set "stats-#{friend['id']}", clean_extra_characters(rsp.body) if rsp.kind_of? Net::HTTPSuccess
    end
  end

  private
  def clean_extra_characters json
    json.reverse.chop.reverse.chop
  end
end
