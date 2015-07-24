class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.integer :inspRequest_id
      t.datetime :schedStart
      t.datetime :schedEnd
      t.boolean :allDay
      t.integer :inspector_id
      t.string :contact
      t.decimal :inspFee
      t.boolean :prepaid
      t.string :pmtMethod
      t.string :pmtRef
      t.text :notes

      t.timestamps
    end
  end
end
