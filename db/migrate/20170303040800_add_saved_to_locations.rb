class AddSavedToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :saved, :boolean, default: false
  end
end
