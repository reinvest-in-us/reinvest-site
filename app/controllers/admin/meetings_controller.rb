class Admin::MeetingsController < Admin::ApplicationController
  before_action :set_police_district

  def index
    @meetings = @district.meetings
  end

  def new
    @meeting = Meeting.new(police_district: @district)
  end

  def edit
    @meeting = Meeting.find(params[:id])

    render :new
  end

  def create
    @meeting = @district.meetings.build(meeting_params)

    if @meeting.valid?
      @meeting.event_datetime = @meeting.event_datetime.change(offset: offset_for_timezone(@district.timezone))
      @meeting.save
      redirect_to admin_police_district_meetings_path(@district)
    else
      render :new
    end
  end

  def update
    @meeting = Meeting.find(params[:id])
    if @meeting.update(meeting_params)
      redirect_to admin_police_district_meetings_path(@district)
    else
      render :new
    end
  end

  private

  def offset_for_timezone(timezone)
    ActiveSupport::TimeZone[timezone].formatted_offset
  end

  def set_police_district
    @district = PoliceDistrict.find_by_slug(params[:police_district_id])
  end

  def meeting_params
    params.require(:meeting).permit(:phone_number, :event_datetime, :agenda_link)
  end
end
