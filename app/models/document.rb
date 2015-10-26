class Document < ActiveRecord::Base
	belongs_to :attachable, polymorphic: true
	has_attached_file :attachment
	validates_attachment_content_type :attachment, content_type: %w( application/msword application/pdf application/vnd.openxmlformats-officedocument.wordprocessingml.document image/jpg image/png )
end
