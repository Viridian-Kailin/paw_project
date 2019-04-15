class CreateLibraries < ActiveRecord::Migration[5.2]
  def change
    create_table :libraries do |t|
      t.string :title
      t.integer :event
      t.integer :badge_log
      t.timestamp :checked_out
      t.timestamp :checked_in
      t.integer :quantity_left

      t.timestamps
    end
  end
end
