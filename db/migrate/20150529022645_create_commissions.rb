class CreateCommissions < ActiveRecord::Migration
  def change
    create_table :commissions do |t|
      t.integer :year
      t.integer :weekNo
      t.decimal :rate

      t.timestamps
    end
  end
end
