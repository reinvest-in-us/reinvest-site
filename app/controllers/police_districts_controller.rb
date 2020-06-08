class PoliceDistrictsController < ApplicationController
  def index
    @districts = PoliceDistrict.all
  end

  def show
    @district = PoliceDistrict.find_by_slug(params[:slug])
  end
end
