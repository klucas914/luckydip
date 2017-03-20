class UsersController < ApplicationController
  
  def saved_locations
    @locations = current_user.locations
  end

  def completed_visits
    @locations = current_user.locations 
    @check_ins = CheckIn.all
  end
end
