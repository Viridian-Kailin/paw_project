class CreateParticipantLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :participant_logs do |t|
      t.integer :game_id
      t.integer :chosen_rating
      t.string :winner_name
      t.integer :winner_badge
      t.string :winner_phone
      t.string :winner_email
      t.string :winner_pref
      t.boolean :winner_proxy
      t.string :proxy_name
      t.integer :proxy_badge
      t.string :proxy_phone
      t.string :proxy_email
      t.string :proxy_pref

      t.timestamps
    end
  end
end
