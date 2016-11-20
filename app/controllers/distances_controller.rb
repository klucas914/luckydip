class DistancesController < ApplicationController
  
  def new
  	@locations = Location.all
  end

  def create
    @from = Location.find_by(id: params[:from])
    @to = Location.find_by(id: params[:to])
    if @from && @to
    	flash[:success] =
    	  "The distance between <b>#{@from.name}</b> and <b>#{@to.name}</b> is #{@from.distance_from(@to.to_coordinates)} km"
    end
    redirect_to new_distance_path
  end

end
