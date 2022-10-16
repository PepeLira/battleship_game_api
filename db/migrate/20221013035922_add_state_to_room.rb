class AddStateToRoom < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :state, :string
  end
end
