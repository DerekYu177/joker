class CreateUser < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.integer :game_id
      t.string :name, null: false
      t.timestamps
    end
  end
end
