class ChangeColumnTypeOfInspectionIdOfBids < ActiveRecord::Migration
  def change
  	change_column :bids, :inspection_id, 'integer USING CAST(inspection_id AS integer)'
  end
end
