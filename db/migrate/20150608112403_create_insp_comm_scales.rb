class CreateInspCommScales < ActiveRecord::Migration
  def change
    create_table :insp_comm_scales do |t|
      t.integer :inspector_id
      t.decimal :scaleStart
      t.decimal :scaleEnd
      t.decimal :rate

      t.timestamps
    end
  end
end
