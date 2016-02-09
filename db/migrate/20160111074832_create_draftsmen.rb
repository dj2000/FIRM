class CreateDraftsmen < ActiveRecord::Migration
  def change
    create_table :draftsmen do |t|
      t.string :first_name
      t.string :last_name
      t.string :middle_initial
      t.string :email

      t.timestamps
    end
  end
end
