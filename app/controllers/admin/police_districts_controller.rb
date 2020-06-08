class Admin::PoliceDistrictsController < Admin::ApplicationController
  def new
    @district = PoliceDistrict.new
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

  def index
    @districts = PoliceDistrict.all
  end

  private

  def district_params
    params.require(:police_district).permit(:name, :fy_2019_policing_budget)
  end
end
