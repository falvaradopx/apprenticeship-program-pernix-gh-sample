class CreateMatches < ActiveRecord::Migration[8.0]
  def change
    create_table :matches do |t|
      t.string :player1_name
      t.string :player1_symbol
      t.integer :player1_wins
      t.string :player2_name
      t.string :player2_symbol
      t.integer :player2_wins
      t.string :difficulty
      t.integer :draws

      t.timestamps
    end
  end
end
