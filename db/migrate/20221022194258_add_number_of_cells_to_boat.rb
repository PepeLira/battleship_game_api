class AddNumberOfCellsToBoat < ActiveRecord::Migration[7.0]
  def change
    add_column :boats, :n_of_cells, :integer
  end
end
