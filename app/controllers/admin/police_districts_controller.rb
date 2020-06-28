class Admin::PoliceDistrictsController < Admin::ApplicationController
  include GoogleCalendarable

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
      :total_district_budget,
      :total_police_department_budget,
      :total_general_fund_budget,
      :total_police_paid_from_general_fund_budget,
      :timezone,
      :address,
      :decision_makers_text,
      :elected_officials_contact_link,
      :law_enforcement_gets_more_than_1,
      :law_enforcement_gets_more_than_2,
      :law_enforcement_gets_more_than_3,
      :law_enforcement_gets_more_than_1_dollars,
      :law_enforcement_gets_more_than_2_dollars,
      :law_enforcement_gets_more_than_3_dollars,
     )
  end
end
