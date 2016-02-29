class AddIsActiveToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_active, :boolean, default: true

    User.all.each do |user|
       user.update(is_active: true)
    end
  end
end
