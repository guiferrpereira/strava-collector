class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_login
    unless authenticated?
      redirect_to login_path
    end
  end

  def authenticated?
    current_user.present?
  end

  def current_user
    @current_user ||= user_from_session
  end
  
  protected
  def user_from_session
    Athlete.find(user_id) if user_id.present?
  end

  def user_id
    session[:user_id]
  end

  def strava_client
    @strava_client ||= Strava::Api::V3::Client.new(access_token: StravaCollector.config.strava[:token])
  end
end
