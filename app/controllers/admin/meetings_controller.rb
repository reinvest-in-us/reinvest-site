class Admin::MeetingsController < Admin::ApplicationController
  before_action :set_police_district

  def new
    @meeting = Meeting.new(police_district: @district)
  end

  def edit
    @meeting = Meeting.find(params[:id])
    @meeting.event_datetime = @meeting.event_datetime.in_time_zone(@district.timezone).asctime

    render :new
  end

  def create
    @meeting = @district.meetings.build(meeting_params)
    @meeting.event_datetime = @meeting.event_datetime.asctime.in_time_zone(@district.timezone)

    if @meeting.save
      redirect_to admin_police_district_path(@district)
    else
      @meeting.event_datetime = @meeting.event_datetime.in_time_zone(@district.timezone).asctime
      render :new
    end
  end

  def update
    @meeting = Meeting.find(params[:id])
    @meeting.assign_attributes(meeting_params)
    @meeting.event_datetime = @meeting.event_datetime.asctime.in_time_zone(@district.timezone)

    if @meeting.save
      redirect_to admin_police_district_path(@district)
    else
      @meeting.event_datetime = @meeting.event_datetime.in_time_zone(@district.timezone).asctime
      render :new
    end
  end

  private

  def set_police_district
    @district = PoliceDistrict.find_by_slug(params[:police_district_id])
  end

  def meeting_params
    params.require(:meeting).permit(
      :phone_number,
      :video_link,
      :event_datetime,
      :agenda_link,
      :agenda_details,
      :how_to_comment
    )
  end
end
