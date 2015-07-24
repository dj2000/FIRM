class AddMailingListToClients < ActiveRecord::Migration
  def change
    add_column :clients, :mailingList, :boolean
  end
end
