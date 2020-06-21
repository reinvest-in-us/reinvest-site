class PoliceDistrictsController < ApplicationController
  include GoogleCalendarable

  def index
    @districts = PoliceDistrict.all
  end

  def show
    @district = PoliceDistrict.find_by_slug(params[:slug])
  end
end
