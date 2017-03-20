class UsersController < ApplicationController
  
  def saved_locations
    @locations = current_user.locations
  end
end
