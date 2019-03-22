class AddAdminToSevenWonders < ActiveRecord::Migration[5.2]
  def change
    add_column :seven_wonders, :admin_id, :integer
  end
end
