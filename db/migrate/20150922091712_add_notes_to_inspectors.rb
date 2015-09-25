class AddNotesToInspectors < ActiveRecord::Migration
  def change
    add_column :inspectors, :notes, :text
  end
end
