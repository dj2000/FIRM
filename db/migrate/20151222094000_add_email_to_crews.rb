class AddEmailToCrews < ActiveRecord::Migration
  def change
    add_column :crews, :email, :string
  end
end
