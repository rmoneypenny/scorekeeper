class CreatePowerGrids < ActiveRecord::Migration[5.2]
  def change
    create_table :power_grids do |t|
      t.integer :game_number
      t.integer :player_id
      t.integer :map_id
      t.boolean :win
      t.integer :score
      t.integer :money
      t.integer :admin_id
      t.datetime :datetime

      t.timestamps
    end
  end
end
