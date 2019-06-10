# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :event_code
      t.string :event_year
      t.string :event_location

      t.timestamps
    end
  end
end
