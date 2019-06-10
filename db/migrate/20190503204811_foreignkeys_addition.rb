# frozen_string_literal: true

class ForeignkeysAddition < ActiveRecord::Migration[5.2]
  def change
    add_column :libraries, :inventory_id, :integer
    add_foreign_key :libraries, :inventories
    add_column :schedules, :inventory_id, :integer
    add_foreign_key :schedules, :inventories
    add_column :game_logs, :inventory_id, :integer
    add_foreign_key :game_logs, :inventories

    add_column :schedules, :paw_staff_id, :integer
    add_foreign_key :schedules, :paw_staffs
    add_column :libraries, :paw_staff_id, :integer
    add_foreign_key :libraries, :paw_staffs

    add_column :game_logs, :participant_id, :integer
    add_foreign_key :game_logs, :participants
    add_column :libraries, :participant_id, :integer
    add_foreign_key :libraries, :participants

    add_column :game_logs, :event_id, :integer
    add_foreign_key :game_logs, :events
    add_column :schedules, :event_id, :integer
    add_foreign_key :schedules, :events
    add_column :libraries, :event_id, :integer
    add_foreign_key :libraries, :events
  end
end
