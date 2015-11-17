class RemoveParentIdFromClients < ActiveRecord::Migration
  def change
  	remove_column :clients, :parent_id
  end
end
