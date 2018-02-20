class AddAdminIdToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :admin_id, :integer
  end
end
