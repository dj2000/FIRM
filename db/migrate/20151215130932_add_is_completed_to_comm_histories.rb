class AddIsCompletedToCommHistories < ActiveRecord::Migration
  def change
    add_column :comm_histories, :is_completed, :boolean, default: false
  end
end
