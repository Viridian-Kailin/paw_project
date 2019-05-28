class CreateActiveLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :active_logs do |t|
      t.integer :rating
      t.integer :inventory_id
      t.integer :badge
      t.string :name
      t.string :phone
      t.string :email
      t.string :pref
      t.boolean :proxy
      t.integer :p_badge
      t.string :p_name
      t.string :p_phone
      t.string :p_email
      t.string :p_pref

      t.timestamps
    end
  end
end
