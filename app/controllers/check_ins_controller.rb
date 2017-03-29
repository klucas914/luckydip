class CheckInsController < ApplicationController
  
  def destroy
    @check_in = CheckIn.find(params[:id])
    @check_in.destroy
    respond_to do |format|
      format.html { redirect_to completed_visits_path, notice: "#{@check_in.location.name} was removed from completed visits." }
      format.json { head :no_content }
    end
  end

  def uncheck
    @check_ins = current_user.check_ins
    if @check_in.delete 
      flash[:notice] = "#{@check_in.location.name} has been removed from completed visits!"
      redirect_to completed_visits_path
    else
      flash[:alert] = "There was an error removing this location from completed visits. Please try again."
    end
  end

end
