# frozen_string_literal: true

class RemoveColumnFromGameLogs < ActiveRecord::Migration[5.2]
  def change
    remove_column :game_logs, :winner
  end
end
