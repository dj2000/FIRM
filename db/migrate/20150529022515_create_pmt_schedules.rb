class CreatePmtSchedules < ActiveRecord::Migration
  def change
    create_table :pmt_schedules do |t|
      t.integer :contract_id
      t.integer :pmtNumber
      t.date :pmtDate
      t.decimal :pmtAmount

      t.timestamps
    end
  end
end
