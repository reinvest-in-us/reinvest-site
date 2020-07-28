class StaticPagesController < ApplicationController
  def about
    render :about
  end

  def page_not_found; end
end
