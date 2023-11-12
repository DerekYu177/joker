class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.integer :game_id
      t.integer :player_id
      t.text :body

      t.timestamps
    end
  end
end
