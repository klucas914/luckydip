class UsersController < ApplicationController
  
  def saved_locations
    @locations = current_user.locations
  end

  def completed_visits
    @check_ins = current_user.check_ins
  end
end
