class AddLocationsAndReviewsToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :locations, foreign_key: true
    add_reference :users, :reviews, foreign_key: true
  end
end
