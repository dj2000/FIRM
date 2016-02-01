class DocumentsController < ApplicationController
  def destroy
    @document = Document.find_by_id(params[:id])
    @inspection = Inspection.find_by_id(params[:inspection_id]) if params[:inspection_id]
    @inspection.documents.destroy(@document) if @inspection
    @project = Project.find_by_id(params[:project_id]) if params[:project_id]
    @project.documents.destroy(@document) if @project
    redirect_to :back
  end
end
