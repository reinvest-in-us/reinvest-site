class Admin::MeetingsController < Admin::ApplicationController
  before_action :set_police_district

  def index
    @meetings = @district.meetings
  end

  def new
    @meeting = Meeting.new(police_district: @district)
  end

  def create
    @meeting = @district.meetings.build(meeting_params)

    if @meeting.valid?
      @meeting.save
      redirect_to admin_police_district_meetings_path(@district)
    else
      render :new
    end
  end

  private

  def set_police_district
    @district = PoliceDistrict.find_by_slug(params[:police_district_id])
  end

  def meeting_params
    params.require(:meeting).permit(:phone_number, :event_datetime, :agenda_link)
  end
end
