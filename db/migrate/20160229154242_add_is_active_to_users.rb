class AddIsActiveToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_active, :boolean, default: true
    User.reset_column_information
    User.update_all(is_active: true)
  end
end
