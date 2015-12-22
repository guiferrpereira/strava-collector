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

  def calculate_friends_totals
    @friends = @current_user.friends

    respond_to do |format|
      format.html
    end
  end
end
