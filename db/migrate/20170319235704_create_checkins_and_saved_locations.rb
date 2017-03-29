class CreateCheckinsAndSavedLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :check_ins do |t|
      t.belongs_to :user,     foreign_key: true, null: false
      t.belongs_to :location, foreign_key: true, null: false
      t.timestamps
    end

    create_table :locations_users do |t|
      t.belongs_to :user,     foreign_key: true, null: false
      t.belongs_to :location, foreign_key: true, null: false
    end

    remove_column :locations, :saved,        :boolean, default: false
    remove_column :locations, :checkin,      :boolean, default: false
    remove_column :locations, :checkin_time, :datetime	
    remove_column :locations, :users_id,     :integer
  end
end
