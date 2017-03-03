class AddCheckinToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :checkin, :boolean, default: false
  end
end
