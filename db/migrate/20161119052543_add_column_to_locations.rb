class AddColumnToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :URL, :string
  end
end
