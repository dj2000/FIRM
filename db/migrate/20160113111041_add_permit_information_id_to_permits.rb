class AddPermitInformationIdToPermits < ActiveRecord::Migration
  def change
    add_column :permits, :permit_information_id, :integer
    remove_column :permits, :project_id, :integer
  end
end
