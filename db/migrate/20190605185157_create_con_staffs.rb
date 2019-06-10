# frozen_string_literal: true

class CreateConStaffs < ActiveRecord::Migration[5.2]
  def change
    create_table :con_staffs do |t|
      t.string :name
      t.string :title
      t.string :phone
      t.string :email
      t.integer :event_id

      t.timestamps
    end
  end
end
