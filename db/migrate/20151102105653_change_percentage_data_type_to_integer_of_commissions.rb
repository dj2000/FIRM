class ChangePercentageDataTypeToIntegerOfCommissions < ActiveRecord::Migration
  def change
  	commission_records = {}
  	commissions = Commission.all
  	commissions.each do |commission|
  		commission_records[commission.id] = commission.percentage
  	end
  	remove_column :commissions, :percentage
  	add_column :commissions, :percentage, :integer
  	Commission.reset_column_information
  	commissions.each do |c|
  		c.update(percentage: commission_records[c.id])
  	end
  end
end
