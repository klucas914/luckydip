class AddDipsToActivities < ActiveRecord::Migration[5.0]
  def change
    add_reference :activities, :dips, foreign_key: true
  end
end
