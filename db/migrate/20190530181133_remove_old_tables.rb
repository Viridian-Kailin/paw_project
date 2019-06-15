# frozen_string_literal: true

#:nodoc:
class RemoveOldTables < ActiveRecord::Migration[5.2]
  def change
    drop_table :participant_logs
  end
end
