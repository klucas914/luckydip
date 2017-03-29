class AddUsersToLocation < ActiveRecord::Migration[5.0]
  def change
    add_reference :locations, :users, foreign_key: true
  end
end
