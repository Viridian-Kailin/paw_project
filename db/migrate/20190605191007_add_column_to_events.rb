# frozen_string_literal: true

#:nodoc:
class AddColumnToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :set, :boolean
  end
end
