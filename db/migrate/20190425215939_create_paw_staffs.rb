# frozen_string_literal: true

#:nodoc:
class CreatePawStaffs < ActiveRecord::Migration[5.2]
  def change
    create_table :paw_staffs, &:timestamps
  end
end
