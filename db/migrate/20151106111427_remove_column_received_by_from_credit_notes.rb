class RemoveColumnReceivedByFromCreditNotes < ActiveRecord::Migration
  def change
  	remove_column :credit_notes, :received_by
  end
end
