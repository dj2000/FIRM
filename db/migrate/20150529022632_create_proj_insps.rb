class CreateProjInsps < ActiveRecord::Migration
  def change
    create_table :proj_insps do |t|
      t.integer :project_id
      t.string :reference
      t.date :scheduleDate
      t.string :inspectBy
      t.date :completeDate
      t.string :result

      t.timestamps
    end
  end
end
