class CreateIFeeSchedules < ActiveRecord::Migration
  def change
    create_table :i_fee_schedules do |t|
      t.boolean :feeActive
      t.date :effectiveFrom
      t.decimal :ownerOccRate
      t.decimal :sfrBaseRate
      t.decimal :sfrIncRate
      t.decimal :mfrBaseRate
      t.decimal :mfrIncRate
      t.decimal :insBaseRate
      t.decimal :insIncRate

      t.timestamps
    end
  end
end
