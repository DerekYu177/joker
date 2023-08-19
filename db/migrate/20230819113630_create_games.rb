class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :name, null: false
      t.json :settings
      t.json :state
      t.timestamps
    end
  end
end