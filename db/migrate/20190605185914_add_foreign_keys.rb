# frozen_string_literal: true

class AddForeignKeys < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :con_staffs, :events
  end
end
