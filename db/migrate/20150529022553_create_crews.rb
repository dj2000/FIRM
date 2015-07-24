class CreateCrews < ActiveRecord::Migration
  def change
    create_table :crews do |t|
      t.string :foreman
      t.integer :size
      t.boolean :doubleBook?
      t.text :notes

      t.timestamps
    end
  end
end
