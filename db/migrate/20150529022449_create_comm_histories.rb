class CreateCommHistories < ActiveRecord::Migration
  def change
    create_table :comm_histories do |t|
      t.integer :inspection_id
      t.string :caller
      t.string :caller
      t.string :recipient
      t.text :callSummary
      t.string :callOutcome
      t.datetime :callBackDate
      t.text :notes

      t.timestamps
    end
  end
end
