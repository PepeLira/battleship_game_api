class AddResultToTurns < ActiveRecord::Migration[7.0]
  def change
    add_column :turns, :result, :string
  end
end
