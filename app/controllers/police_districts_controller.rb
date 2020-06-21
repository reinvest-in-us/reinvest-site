class PoliceDistrictsController < ApplicationController
  include GoogleCalendarable

  def index
    @districts = PoliceDistrict.with_upcoming_meetings
  end

  def show
    @district = PoliceDistrict.find_by_slug(params[:slug])
  end
end
