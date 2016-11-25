class AddDipToActivity < ActiveRecord::Migration[5.0]
  def change
    add_reference :activities, :dip, foreign_key: true
  end
end
