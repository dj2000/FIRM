class AddAttachmentToPermits < ActiveRecord::Migration
  def change
  	add_attachment :permits, :attachment
  end
end
