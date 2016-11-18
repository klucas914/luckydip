class CreateDips < ActiveRecord::Migration[5.0]
  def change
    create_table :dips do |t|
      t.string :mood_for
      t.integer :distance

      t.timestamps
    end
  end
end
