class ChangeColumnTypesOfSvcCriterium < ActiveRecord::Migration
  def self.up
    remove_column :svc_criteria, :prevInsp
    remove_column :svc_criteria, :hpoz
    remove_column :svc_criteria, :cdo
    remove_column :svc_criteria, :ownerOcc
  	add_column :svc_criteria, :prevInsp, :integer
  	add_column :svc_criteria, :hpoz, :integer
  	add_column :svc_criteria, :cdo, :integer
    add_column :svc_criteria, :ownerOcc, :integer
  end
  def self.down
    change_column :svc_criteria, :prevInsp, :string
    change_column :svc_criteria, :hpoz, :string
    change_column :svc_criteria, :cdo, :string
    change_column :svc_criteria, :ownerOcc, :string
  end
end
