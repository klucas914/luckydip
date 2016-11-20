class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.references :location, foreign_key: true
      t.text :review

      t.timestamps
    end
  end
end
