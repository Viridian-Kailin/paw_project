class CreateGameLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :game_logs do |t|
      t.string :title
      t.timestamp :timestamp
      t.integer :badge_log
      t.integer :rating

      t.timestamps
    end
  end
end
