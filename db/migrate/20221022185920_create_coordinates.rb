class CreateCoordinates < ActiveRecord::Migration[7.0]
  def change
    create_table :coordinates do |t|
      t.string :state
      t.integer :x
      t.integer :y

      t.timestamps
    end
  end
end
