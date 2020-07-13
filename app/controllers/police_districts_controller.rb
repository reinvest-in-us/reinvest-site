class PoliceDistrictsController < ApplicationController
  include GoogleCalendarable

  def index
    @districts_with_future_meetings = (params[:near].present? ? PoliceDistrict.near(params[:near]) : PoliceDistrict.all).with_upcoming_meetings
    @districts_with_past_meetings = (params[:near].present? ? PoliceDistrict.near(params[:near]) : PoliceDistrict.all).with_only_past_meetings
  end

  def show
    @district = PoliceDistrict.find_by_slug!(params[:slug])
    @meeting = @district.next_meeting.present? ? @district.next_meeting : @district.most_recent_meeting
    @open_graph_description = "Find where and how to give public comment on #{@district.name} police budgets."
  end
end
