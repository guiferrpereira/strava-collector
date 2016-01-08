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
      friend_with_stats = @redis.get("stats-#{friend['id']}")

      if friend_with_stats.nil? || !friend.has_key?("last_time_checked")
        process_data(friend['id'])
      elsif friend_with_stats["last_time_checked"].to_i < (Time.now - 1.hour).to_i
        process_data(friend['id'])
      end
    end
  end

  private
  def clean_extra_characters json
    json.reverse.chop.reverse.chop
  end

  def add_datetime_info data
    json = JSON.parse(clean_extra_characters(data))
    json["last_time_checked"] = Time.now.to_i
    json
  end

  def process_data friend_id
    uri = URI("#{StravaCollector.config.strava_scraper[:url]}/#{friend['id']}")
    rsp = Net::HTTP.get_response(uri)

    if rsp.kind_of? Net::HTTPSuccess
      @redis.set "stats-#{friend['id']}", add_datetime_info(rsp.body)
    end
  end
end
