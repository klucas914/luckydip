class AddColumnToDips < ActiveRecord::Migration[5.0]
  def change
    add_column :dips, :place, :string
  end
end
