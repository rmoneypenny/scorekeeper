class CreateSevenWonderBoards < ActiveRecord::Migration[5.0]
  def change
    create_table :seven_wonder_boards do |t|
      t.string :name
      t.string :expansion

      t.timestamps
    end
  end
end
