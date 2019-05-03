class SetupForForeignkeys < ActiveRecord::Migration[5.2]
  def change
    remove_column :schedules, :event
    remove_column :schedules, :title
    remove_column :schedules, :assigned

    add_column :schedules, :events_id, :integer
    add_column :schedules, :inventories_id, :integer
    add_column :schedules, :paw_staff_id, :integer

    remove_column :game_logs, :title
    remove_column :game_logs, :badge
    remove_column :game_logs, :event

    add_column :game_logs, :inventories_id, :integer
    add_column :game_logs, :participants_id, :integer
    add_column :game_logs, :events_id, :integer

    remove_column :libraries, :title
    remove_column :libraries, :event
    remove_column :libraries, :badge

    add_column :libraries, :inventories_id, :integer
    add_column :libraries, :events_id, :integer
    add_column :libraries, :participants_id, :integer
  end
end
