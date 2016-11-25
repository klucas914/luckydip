class RemoveDipsFromActivities < ActiveRecord::Migration[5.0]
  def change
    remove_reference :activities, :dips, foreign_key: true
  end
end
