class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.integer :game_id, null: false
      t.integer :current_score_card_rank, default: 0, null: false

      t.timestamps
    end
  end
end
