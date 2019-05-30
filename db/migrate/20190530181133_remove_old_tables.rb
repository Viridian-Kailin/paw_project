class RemoveOldTables < ActiveRecord::Migration[5.2]
  def change
    drop_table :con_staffs
    drop_table :participant_logs
  end
end
