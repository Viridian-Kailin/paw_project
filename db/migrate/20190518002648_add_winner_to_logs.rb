# frozen_string_literal: true

#:nodoc:
class AddWinnerToLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :game_logs, :winner, :boolean
  end
end
