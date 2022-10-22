class RemoveBonificationFromBoard < ActiveRecord::Migration[7.0]
  def change
    remove_column :boards, :bonifications, :string
  end
end
