class AddColumnBidIdToCommHistories < ActiveRecord::Migration
  def change
    add_column :comm_histories, :bid_id, :integer
  end
end
