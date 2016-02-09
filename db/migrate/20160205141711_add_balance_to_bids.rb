class AddBalanceToBids < ActiveRecord::Migration
  def change
    add_column :bids, :balance, :float
  end
end
