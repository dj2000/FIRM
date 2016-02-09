class AddStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :status, :string, default: "Pending"
    User.reset_column_information
    User.update_all(status: "Approved")
  end
end
