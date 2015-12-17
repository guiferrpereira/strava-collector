class TemporaryController < ApplicationController
  before_filter :require_login

  def index
    @activities ||= Activity.all(@current_user.id)

    respond_to do |format|
      format.html
    end
  end

  def update_activities
    CollectActivitiesJob.perform_now(@current_user.access_token)

    redirect_to root_url
  end
end
