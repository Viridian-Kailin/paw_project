# frozen_string_literal: true

class CreatePawStaffs < ActiveRecord::Migration[5.2]
  def change
    create_table :paw_staffs do |t|
      t.timestamps
    end
  end
end
