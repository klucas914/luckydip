class ReviewsController < ApplicationController
  
  def index
    @reviews = Review.all
    @locations = Location.all
  end

  def show
  	@review = Review.find(params[:id])
  	@location = Location.all
  end

  def new
    @review = Review.new
   
  end

  def edit
    @review = Review.find(params[:id])
  end

  def create
  	@review = Review.new(review_params)
   
    respond_to do |format|
      if @review.save
        format.html { redirect_to @review, notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
   end
 
  def update
    @review = Review.find(params[:id])
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:comments, :location_id, location_attributes: [:name, :address])
    end
end



