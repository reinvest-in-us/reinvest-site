class PoliceDistrictsController < ApplicationController
  include GoogleCalendarable

  def index
    @districts_with_future_meetings = (params[:near].present? ? PoliceDistrict.near(params[:near]) : PoliceDistrict.all).with_upcoming_meetings
    @districts_with_past_meetings = (params[:near].present? ? PoliceDistrict.near(params[:near]) : PoliceDistrict.all).with_only_past_meetings
  end

  def show
    @district = PoliceDistrict.find_by_slug(params[:slug])
  end
end
