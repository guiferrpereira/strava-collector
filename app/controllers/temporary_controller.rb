class TemporaryController < ApplicationController
  before_filter :require_login

  def index
    @activities = @current_user.activities

    respond_to do |format|
      format.html
    end
  end

  def update_activities
    CollectActivitiesJob.perform_now(@current_user.access_token)

    redirect_to root_url
  end

  def update_stats
    CollectFriendsStats.perform_now(@current_user.access_token)

    redirect_to leaderboards_url
  end

  def calculate_friends_totals
    @friends = @current_user.friends

    respond_to do |format|
      format.html
    end
  end

  def calculate_followers_totals
    @followers = @current_user.followers

    respond_to do |format|
      format.html
    end
  end
end
