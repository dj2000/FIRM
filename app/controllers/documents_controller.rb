class DocumentsController < ApplicationController
	def destroy
		@document = Document.find(params[:id])
		@attachable = @document.attachable
		@document.destroy
		respond_to do |format|
			format.js
		end
	end
end
