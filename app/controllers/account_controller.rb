class AccountController < ApplicationController
  def login
  end

  def authorize
    user = Authentication.new(params).authenticate
    if user.present?
      session[:user_id] = user.id
      redirect_to activities_url
    else
      render text: "Unable to authenticate with Strava."
    end
  end
end
