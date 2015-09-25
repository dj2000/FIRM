class AddColumnTitleToBids < ActiveRecord::Migration
  def change
    add_column :bids, :title, :string
  end
end
