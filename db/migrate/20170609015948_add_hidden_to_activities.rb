class AddHiddenToActivities < ActiveRecord::Migration[5.0]
  def change
    add_column :activities, :hidden, :boolean, default: false
  end
end
