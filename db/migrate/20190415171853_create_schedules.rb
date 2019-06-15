# frozen_string_literal: true

#:nodoc:
class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.integer :event
      t.integer :title_id
      t.timestamp :start
      t.timestamp :end
      t.string :assigned
      t.string :location

      t.timestamps
    end
  end
end
