class Admin::MeetingsController < Admin::ApplicationController
  before_action :set_police_district

  include Timezonable

  def new
    @meeting = district.meetings.build

    render :new
  end

  def edit
    @meeting = district.meetings.find(params[:id])
    @meeting.event_datetime = convert_and_strip_timezone(@meeting.event_datetime, @district.timezone)

    render :edit
  end

  def create
    @meeting = @district.meetings.build(meeting_params)
    @meeting.event_datetime = set_timezone(@meeting.event_datetime, @district.timezone)

    if @meeting.save
      redirect_to admin_police_district_path(@district)
    else
      @meeting.event_datetime = convert_and_strip_timezone(@meeting.event_datetime, @district.timezone)
      render :new
    end
  end

  def update
    @meeting = district.meetings.find(params[:id])
    @meeting.assign_attributes(meeting_params)
    @meeting.event_datetime = set_timezone(@meeting.event_datetime, @district.timezone)

    if @meeting.save
      redirect_to admin_police_district_path(@district)
    else
      @meeting.event_datetime = convert_and_strip_timezone(@meeting.event_datetime, @district.timezone)
      render :edit
    end
  end

  def destroy
    @meeting = district.meetings.find(params[:id])
    @meeting.destroy

    respond_to do |format|
      format.js
    end
  end

  private

  attr_reader :district

  def set_police_district
    @district = PoliceDistrict.find_by_slug!(params[:police_district_id])
  end

  def meeting_params
    params.require(:meeting).permit(
      :video_link,
      :event_datetime,
      :agenda_link,
      :agenda_details,
      :how_to_comment,
      :about
    )
  end
end
