class CreatePermits < ActiveRecord::Migration
  def change
    create_table :permits do |t|
      t.string :reference
      t.integer :project_id
      t.date :issueDate
      t.string :issuedBy
      t.string :status
      t.decimal :valuation

      t.timestamps
    end
  end
end
