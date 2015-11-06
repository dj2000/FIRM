class CreateCommissions < ActiveRecord::Migration
  def change
		drop_table :commissions if (table_exists? :kittens)
    create_table :commissions do |t|
      t.integer :inspector_id
      t.integer :commission_rate_id
      t.string :percentage
      t.timestamps
    end
  end
end
