class AddNotesToAgent < ActiveRecord::Migration
  def change
    add_column :agents, :notes, :text
  end
end
