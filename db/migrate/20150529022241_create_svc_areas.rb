class CreateSvcAreas < ActiveRecord::Migration
  def change
    create_table :svc_areas do |t|
      t.integer :zip
      t.string :city
      t.string :state
      t.boolean :serviced

      t.timestamps
    end
  end
end
