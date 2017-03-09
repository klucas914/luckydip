class DipsController < ApplicationController

  # GET /dips
  # GET /dips.json
  def index
    @dips = Dip.all
    @activities = Activity.all
    @location_types = LocationType.all
    

    #@activity = Activity.find(@dip.activity_id)
    #@location_type = LocationType.find(@dip.location_type_id)
  
  end

  # GET /dips/1
  # GET /dips/1.json
  def show
    @dip = Dip.find(params[:id])
    @activity = Activity.find(@dip.activity_id)
    @location_type = LocationType.find(@dip.location_type_id)
    ip_address = "49.176.105.223"
    #@ip_address = request.remote_ip
    coordinates = Geocoder.coordinates(ip_address)
    @locations = @dip.matching_locations(coordinates[0], coordinates[1])
    #@locations = @dip.locations.all
  
  end

  # GET /dips/new
  def new
    @dip = Dip.new
    @activities = Activity.all
    @location_types = LocationType.all
  end

  # GET /dips/1/edit
  def edit
    @dip = Dip.new
    @activities = Activity.all
    @location_types = LocationType.all
  end


  def create
    @dip = Dip.new(dip_params)

    respond_to do |format|
      if @dip.save
        
        format.html { redirect_to @dip, notice: 'Dip was successfully created.' }
        format.json { render :show, status: :created, location: @dip }
      else
        format.html { render :new }
        format.json { render json: @dip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dips/1
  # PATCH/PUT /dips/1.json
  def update
    respond_to do |format|
      if @dip.update(dip_params)
        format.html { redirect_to @dip, notice: 'Dip was successfully updated.' }
        format.json { render :show, status: :ok, location: @dip }
      else
        format.html { render :edit }
        format.json { render json: @dip.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_selection
    dip = Dip.find(params[:id])

    activity_id = dip_params[:activity_id]
    location_type_id = dip_params[:location_type_id]

    location = Location.all.where(activity_id: activity_id, location_type_id: location_type_id)

    selection = Selection.new(dip_id: dip, location_id: location)
    
    respond_to do |format|
      if selection.save!
        format.html { redirect_to @dip, notice: 'Location was successfully matched.' }
        format.json { render :show, status: :created, location: @dip }
      else
        format.html { render :show, notice: 'There was an error matching a location to the dip.' }
        format.json { render json: selection.errors, status: :unprocessable_entity }
      end
    end
  end

  

  # DELETE /dips/1
  # DELETE /dips/1.json
  def destroy
    @dip.destroy
    respond_to do |format|
      format.html { redirect_to dips_url, notice: 'Dip was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dip
      #@dip = Dip.find(params[:id])
      @dip = Dip.find_by(id: params[:id])
    end

    def location_params
      params.require(:location).permit(:name, :address, :location_type_id, :activity_id)
    end

    def selection_params
      params.require(:selection).permit(:location_id, :dip_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dip_params
      params.require(:dip).permit(:distance, :activity_id, :location_type_id, activities_attributes: [:name], location_types_attributes: [:name])
    end

end
