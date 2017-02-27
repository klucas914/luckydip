class AddReviewToLocations < ActiveRecord::Migration[5.0]
  def change
    add_reference :locations, :review, foreign_key: true
  end
end
