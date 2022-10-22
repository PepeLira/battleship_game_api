class RemoveBoardStateFromBoard < ActiveRecord::Migration[7.0]
  def change
    remove_column :boards, :board_state, :string
  end
end
