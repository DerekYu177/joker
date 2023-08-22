class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.integer :game_id, null: false
      t.integer :user_id, null: false
      t.integer :team_id
      t.timestamps
    end
  end
end
