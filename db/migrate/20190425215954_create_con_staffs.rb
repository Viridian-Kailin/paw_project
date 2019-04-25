class CreateConStaffs < ActiveRecord::Migration[5.2]
  def change
    create_table :con_staffs do |t|

      t.timestamps
    end
  end
end
