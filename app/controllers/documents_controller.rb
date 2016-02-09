class DocumentsController < ApplicationController
  def destroy
    @document = Document.find_by_id(params[:id])
    @attachable_type = params[:attachable_type]
    @parent = @attachable_type.constantize.find_by_id(params[:parent_id])
    @parent.documents.destroy(@document)
    @doc_type = params[:doc_type]
    respond_to :js
  end
end
