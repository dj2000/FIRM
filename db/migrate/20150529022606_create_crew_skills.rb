class CreateCrewSkills < ActiveRecord::Migration
  def change
    create_table :crew_skills do |t|
      t.integer :crew_id
      t.string :skill_id

      t.timestamps
    end
  end
end
