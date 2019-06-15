# frozen_string_literal: true

#:nodoc:
class SetDefaultBooleanEvents < ActiveRecord::Migration[5.2]
  def change
    change_column :events, :set, :boolean, default: false
  end
end
