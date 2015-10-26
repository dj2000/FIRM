class Document < ActiveRecord::Base
	belongs_to :attachable, polymorphic: true
	has_attached_file :attachment

	scope :email_documents, -> { where( document_type: 'email' ) }
	scope :other_documents, -> { where( document_type: nil ) }

	validates_attachment_content_type :attachment, content_type: %w( application/msword application/pdf )
end
