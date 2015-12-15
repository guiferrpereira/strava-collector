class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_filter do
  #   @current_user ||= current_user
  # end

  protected
  def current_user
    Athlete.new(strava_client.retrieve_current_athlete)
  end

  def strava_client
    @strava_client ||= Strava::Api::V3::Client.new(access_token: StravaCollector.config.strava[:token])
  end
end
