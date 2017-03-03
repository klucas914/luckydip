class LocationsController < ApplicationController
  #before_action :set_location, only: [:show, :edit, :update, :destroy]


  # GET /locations.json
  def get_location
    @location = Location.find(params[:id])
    if Geocoder.coordinates(@location)
      render {:show}
    else 
      puts "sorry, try again"
    end
    #Location.near('Mooloolaba, Qld, AU', 20, :units => :km)
  end

  def index
    @locations = Location.all
    @activities = Activity.all
    @location_types = LocationType.all
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @location = Location.find(params[:id])
    @review = Review.all

    
    
  end

  # GET /locations/new
  def new
    @location = Location.new
    @activities = Activity.all
    @location_types = LocationType.all

  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
    @activities = Activity.all
    @location_types = LocationType.all
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)
    #@activities = Activity.all
    #@location_types = LocationType.all

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    @location = Location.find(params[:id])
    #raise location_params.inspect
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  def save
    @location = Location.find(params[:id])
    if @location.update(saved: :true)
      flash[:notice] = "#{@location.name} has been added to saved locations!"
      redirect_to new_dip_path
    else
      flash[:alert] = "There was an error adding this location to saved locations. Please try again."
    end
  end 

  def store
    @locations = Location.where("saved IS TRUE").reverse.each
     
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:name, :address, :saved, :description, :lat, :lon, :review => [:comments], :activity => [:name], :location_type => [:name], activity_ids: [], location_type_ids: [])
    end
end
