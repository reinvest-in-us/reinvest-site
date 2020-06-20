class Admin::PoliceDistrictsController < Admin::ApplicationController
  def new
    @district = PoliceDistrict.new

    render :new
  end

  def create
    @district = PoliceDistrict.new(district_params)

    if @district.valid?
      @district.save
      redirect_to admin_police_districts_path
    else
      render :new
    end
  end

  def show
    @district = PoliceDistrict.find_by_slug(params[:id])
    @meetings = @district.meetings.order(event_datetime: :desc)
    @elected_officials = @district.elected_officials.order(:list_rank)
  end

  def edit
    @district = PoliceDistrict.find_by_slug(params[:id])

    render :edit
  end

  def update
    @district = PoliceDistrict.find_by_slug(params[:id])
    if @district.update(district_params)
      redirect_to admin_police_districts_path
    else
      render :edit
    end
  end

  def index
    @districts = PoliceDistrict.all
  end

  private

  def district_params
    params.require(:police_district).permit(
      :name,
      :fy_2019_policing_budget,
      :general_fund_percent,
      :timezone,
      :decision_makers,
      :decision_makers_text,
      :law_enforcement_gets_more_than_1,
      :law_enforcement_gets_more_than_2,
      :law_enforcement_gets_more_than_3,
      :law_enforcement_gets_more_than_1_dollars,
      :law_enforcement_gets_more_than_2_dollars,
      :law_enforcement_gets_more_than_3_dollars,
     )
  end
end
