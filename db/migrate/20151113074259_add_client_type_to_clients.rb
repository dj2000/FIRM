class AddClientTypeToClients < ActiveRecord::Migration
  def change
    add_column :clients, :client_type, :string
    add_column :clients, :company_name, :string
    add_column :clients, :of_type, :string
    Client.reset_column_information
    Client.update_all(of_type: "Individual")
  end
end
