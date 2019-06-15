# frozen_string_literal: true

#:nodoc:
class AddColumns < ActiveRecord::Migration[5.2]
  def change
    change_table :paw_staffs do |t|
      t.integer :badge
      t.string :name
      t.string :title
      t.string :phone
      t.string :email
      t.string :role
    end
  end
end
