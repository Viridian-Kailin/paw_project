# frozen_string_literal: true

class CreateParticipants < ActiveRecord::Migration[5.2]
  def change
    create_table :participants do |t|
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
