class CreateInspSkills < ActiveRecord::Migration
  def change
    create_table :insp_skills do |t|
      t.integer :inspector_id
      t.string :skill_id

      t.timestamps
    end
  end
end
