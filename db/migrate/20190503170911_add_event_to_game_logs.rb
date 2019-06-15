# frozen_string_literal: true

#:nodoc:
class AddEventToGameLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :game_logs, :event, :string
  end
end
