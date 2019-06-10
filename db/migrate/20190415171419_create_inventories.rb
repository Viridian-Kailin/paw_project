# frozen_string_literal: true

class CreateInventories < ActiveRecord::Migration[5.2]
  def change
    create_table :inventories do |t|
      t.string :title
      t.string :company
      t.integer :quantity_total

      t.timestamps
    end
  end
end
