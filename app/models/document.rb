class Document < ActiveRecord::Base
	belongs_to :attachable, polymorphic: true
	has_attached_file :attachment

	scope :email_documents, -> { where( document_type: 'email' ) }
	scope :other_documents, -> { where( document_type: nil ) }

	validates_attachment_content_type :attachment, content_type: %w( application/msword application/pdf application/vnd.openxmlformats-officedocument.wordprocessingml.document )

	def file_url
		public_path = Rails.root.join("public", "pdfs", "#{self.attachable_id}", "#{self.attachment_file_name}.pdf")
		File.exists?(public_path) ? public_path : self.attachment.url
	end
end
