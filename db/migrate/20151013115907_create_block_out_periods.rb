class CreateBlockOutPeriods < ActiveRecord::Migration
  def change
    create_table :block_out_periods do |t|
      t.integer :appointment_id
      t.datetime :schedStart
      t.datetime :schedEnd
      t.boolean :allDay
      t.integer :inspector_id
      t.timestamps
    end
  end
end
