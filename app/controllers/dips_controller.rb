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
    @locations = Location.all.where(activity_id: @activity, location_type_id: @location_type)
  
  #@locations = Location.where("locations.activity_id == dip.activity_id && locations.location_type_id == dip.location_type_id")
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
  
  

  #def create_selection
   # dip = Dip.find(params[:id])

    #activity = dip.activity_id

    #location_type = dip.location_type_id

    #selection = Selection.new(activity_id: activity, location_type_id: location_type)

    #if selection.save!
      #redirect to dip_path(@dip)
    #else
     # redirect to new_dip_path
    #end

  #end


  #def pick_location
  #end
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
      @dip = Dip.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dip_params
      params.require(:dip).permit(:mood_for, :distance, :activity_id, :location_type_id, activities_attributes: [:name], location_types_attributes: [:name])
    end

end
