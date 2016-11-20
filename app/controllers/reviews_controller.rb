class ReviewsController < ApplicationController
  
  def new
    @reviews = Review.new
  end

  def create
  	@review = Review.new(params[:id])
  end

end
