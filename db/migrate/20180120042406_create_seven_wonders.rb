class CreateSevenWonders < ActiveRecord::Migration[5.0]
  def change
    create_table :seven_wonders do |t|
      t.integer :game_number
      t.integer :player_id
      t.integer :board_id
      t.boolean :win
      t.integer :score
      t.datetime :datetime

      t.timestamps
    end
  end
end
