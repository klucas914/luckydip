class CheckInsController < ApplicationController
  def index
    @check_ins = CheckIn.all
  end

end
