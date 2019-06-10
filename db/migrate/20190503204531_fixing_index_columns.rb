# frozen_string_literal: true

class FixingIndexColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :libraries, :inventories_id
    remove_column :libraries, :events_id
    remove_column :libraries, :participants_id

    remove_column :game_logs, :inventories_id
    remove_column :game_logs, :participants_id
    remove_column :game_logs, :events_id

    remove_column :schedules, :inventories_id
    remove_column :schedules, :events_id
    remove_column :schedules, :paw_staff_id
  end
end
