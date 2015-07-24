class AddMailingListToAgents < ActiveRecord::Migration
  def change
    add_column :agents, :mailingList, :boolean
  end
end
