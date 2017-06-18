class AddHiddenToLocationTypes < ActiveRecord::Migration[5.0]
  def change
    add_column :location_types, :hidden, :boolean, default: false
  end
end
