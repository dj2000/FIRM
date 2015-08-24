class RenameColumnDoubleBookOfCrews < ActiveRecord::Migration
  def change
  	rename_column :crews, :doubleBook?, :double_book
  end
end
