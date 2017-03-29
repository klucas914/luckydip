class AddSccOpenDataIdToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :scc_open_data_id, :integer
  end
end

