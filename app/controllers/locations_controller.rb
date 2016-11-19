class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  #def get_bounding_box latitude longitude distance
   # return "%7Bxmin%3A+153.073286%2C+ymin%3A+-26.650181%2C+xmax%3A+153.087902%2C+ymax%3A+-26.641052%7D"
  #end

  #def get_location_features location latitude longitude distance
   # @location_features = json.parse(data)
  #end
  # GET /locations
  # GET /locations.json
  def index
    # https://gisservices.scc.qld.gov.au/arcgis/rest/services/Society/Society_SCRC/MapServer/42/query?where=1%3D1&text=&objectIds=&time=&geometry=%7Bxmin%3A+153.073286%2C+ymin%3A+-26.650181%2C+xmax%3A+153.087902%2C+ymax%3A+-26.641052%7D&geometryType=esriGeometryEnvelope&inSR=4326&spatialRel=esriSpatialRelIntersects&relationParam=&outFields=*&returnGeometry=true&maxAllowableOffset=&geometryPrecision=&outSR=4326&returnIdsOnly=false&returnCountOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&returnZ=false&returnM=false&gdbVersion=&returnDistinctValues=false&f=pjson
    @locations = Location.all
    @activities = Activity.all
    @location_types = LocationType.all
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
  end

  # GET /locations/new
  def new
    @location = Location.new
    @activities = Activity.all
    @location_types = LocationType.all

  end

  # GET /locations/1/edit
  def edit
    @location = Location.new
    @activities = Activity.all
    @location_types = LocationType.all
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)
    @activities = Activity.all
    @location_types = LocationType.all

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

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
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
      params.require(:location).permit(:name, :address, :activity_id, :location_type_id, :activity => [:name], :location => [:name])
    end
end
