class CreateBoards < ActiveRecord::Migration[7.1]
  def change
    create_table :boards do |t|
      t.string :name
      t.string :email
      t.integer :width
      t.integer :height

      t.timestamps
    end

    add_index :boards, :name
    add_index :boards, :email
  end
end
