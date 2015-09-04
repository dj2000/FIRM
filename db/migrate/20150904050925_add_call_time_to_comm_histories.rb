class AddCallTimeToCommHistories < ActiveRecord::Migration
  def change
    add_column :comm_histories, :call_time, :datetime
  end
end
