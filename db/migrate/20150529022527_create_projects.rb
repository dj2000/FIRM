class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.date :vcDate
      t.integer :contract_id
      t.decimal :jobCost
      t.date :scheduleBy
      t.string :schedulePref
      t.integer :estDuration
      t.date :scheduleStart
      t.date :scheduleEnd
      t.string :authorizedBy
      t.date :authorizedOn
      t.integer :crew_id
      t.boolean :verifiedAccess
      t.boolean :verifiedEW
      t.text :notes

      t.timestamps
    end
  end
end
