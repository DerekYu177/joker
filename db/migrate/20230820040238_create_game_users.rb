class CreateGameUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :game_users do |t|
      t.integer :game_id, null: false
      t.integer :user_id, null: false
      t.integer :team_id, null: false
      t.timestamps
    end
  end
end
