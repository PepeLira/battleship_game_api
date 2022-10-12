class CreateTurns < ActiveRecord::Migration[7.0]
  def change
    create_table :turns do |t|
      t.integer :x_cord
      t.integer :y_cord

      t.timestamps
    end
  end
end
