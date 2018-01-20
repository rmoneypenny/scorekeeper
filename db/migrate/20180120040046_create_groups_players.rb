class CreateGroupsPlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :groups_players do |t|
      t.references :player, foreign_key: true
      t.references :group, foreign_key: true
    end
  end
end
