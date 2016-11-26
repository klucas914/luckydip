module ReviewsHelper

  def location_options
    Location.order(:id)
  end

end
