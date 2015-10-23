class AddIsOptOutMailerToClients < ActiveRecord::Migration
  def change
    add_column :clients, :is_opt_out_mailer, :boolean
  end
end
