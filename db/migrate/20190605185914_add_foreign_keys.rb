# frozen_string_literal: true

#:nodoc:
class AddForeignKeys < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :con_staffs, :events
  end
end
