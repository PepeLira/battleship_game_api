class CreateBoard < ActiveRecord::Migration[7.0]
  def change
    create_table :boards do |t|
      t.string :bonifications
      t.string :board_state

      t.timestamps
    end
  end
end
