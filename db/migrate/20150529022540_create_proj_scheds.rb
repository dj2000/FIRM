class CreateProjScheds < ActiveRecord::Migration
  def change
    create_table :proj_scheds do |t|
      t.integer :project_id
      t.integer :crew_id
      t.date :date
      t.time :startTime
      t.time :endTime
      t.text :notes

      t.timestamps
    end
  end
end
