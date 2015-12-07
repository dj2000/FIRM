class AddApprovedToUser < ActiveRecord::Migration
  def change
    add_column :users, :approved, :boolean, default: false
    User.reset_column_information
    User.update_all(approved: true)
  end
end
