class AddActivityToDips < ActiveRecord::Migration[5.0]
  def change
    add_reference :dips, :activity, foreign_key: true
  end
end
