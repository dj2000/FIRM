class CreateCommissionRates < ActiveRecord::Migration
  def change
    create_table :commission_rates do |t|
      t.integer :scale_start
      t.integer :scale_end
      t.string :title
      t.timestamps
    end
  end
end
