class CreateBoardMines < ActiveRecord::Migration[7.1]
  def change
    create_table :board_mines do |t|
      t.references :board, null: false, foreign_key: true
      t.integer :x
      t.integer :y

      t.timestamps
    end

    add_index :board_mines, [:board_id, :x, :y], unique: true, name: "index_board_mines_on_board_id_and_x_and_y"
  end
end
