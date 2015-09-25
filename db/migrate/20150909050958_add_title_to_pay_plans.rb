class AddTitleToPayPlans < ActiveRecord::Migration
  def change
    add_column :pay_plans, :title, :string
  end
end
