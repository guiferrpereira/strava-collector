class TemporaryController < ApplicationController
  def index
    @activities ||= Activity.all(@current_user.id)

    respond_to do |format|
      format.html
    end
  end
end
