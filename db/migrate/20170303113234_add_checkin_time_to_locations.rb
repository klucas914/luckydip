class AddCheckinTimeToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :checkin_time, :timestamp
  end
end
