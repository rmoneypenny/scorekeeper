class AddUniqueIndexToPlayers < ActiveRecord::Migration[5.2]
  def change
  	add_index :players, [:name, :admin_id], unique: true
  end
end
