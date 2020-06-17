class Admin::ElectedOfficialsController < Admin::ApplicationController
    before_action :set_police_district
  
    def new
      @elected_official = ElectedOfficial.new(police_district: @district)
    end
  
    def edit
      @elected_official = ElectedOfficial.find(params[:id])
  
      render :new
    end
  
    def create
      @elected_official = @district.elected_officials.build(elected_official_params)
  
      if @elected_official.save
        redirect_to admin_police_district_path(@district)
      else
        render :new
      end
    end
  
    def update
      @elected_official = ElectedOfficial.find(params[:id])
      @elected_official.assign_attributes(elected_official_params)
      
      if @elected_official.save
        redirect_to admin_police_district_path(@district)
      else
        render :new
      end
    end
  
    private
  
    def set_police_district
      @district = PoliceDistrict.find_by_slug(params[:police_district_id])
    end
  
    def elected_official_params
      params.require(:elected_official).permit(:name, :position, :reelection_date, :list_rank)
    end
  end
  