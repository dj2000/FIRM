class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :send_email_to_crew]
  before_action :contracts

  # GET /projects
  # GET /projects.json
  def index
    if params[:client_id].present? || params[:property_id].present?
      if params[:search_filter] == "Property"
        @projects = Project.joins(:contract => [:bid => [:inspection => [:appointment => :insp_request]]]).where("insp_requests.property_id = ? ", params[:property_id])
      elsif params[:search_filter] == "Client"
        @projects = Project.joins(:contract => [:bid => [:inspection => [:appointment => :insp_request]]]).where("insp_requests.client_id = ? ", params[:client_id])
      end
    else
      @projects = Project.all
    end
    @properties = Property.all.map{|p| [p.property_select_value, p.id]}
    @clients = Client.all.map{|c| [c.name, c.id]}
    respond_to do |format|
      format.js
      format.csv { send_data Project.as_csv }
      format.html
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
    @permit_information = @project.build_permit_information
  end

  # GET /projects/1/edit
  def edit
    @permit_information = @project.permit_information || @project.build_permit_information
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    create_documents
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        @permit_information = @project.permit_information || @project.build_permit_information
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    create_documents
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def print
    @projects = Project.all
    respond_to do |format|
      format.js
    end
  end

  def send_email_to_crew
    UserMailer.send_email_to_crew(@project).deliver
    respond_to do |format|
      format.html{ redirect_to project_url(@project), notice: 'Email is sent successfully.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
      @contract = @project.try(:contract) || Contract.find(params[:project][:contract_id])
      @bid = @contract.try(:bid)
      @clients = @bid.try(:inspection).try(:appointment).try(:insp_request).try(:property).try(:clients)
      @permit_information = @project.try(:permit_information)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params[:project].delete :permit_information_attributes if params[:project][:permit] == "0"
      params.require(:project).permit(:vcDate, :contract_id, :jobCost, :schedulePref, :estDuration, :scheduleStart, :scheduleEnd, :authorizedBy, :authorizedOn, :crew_id, :verifiedAccess, :verifiedEW, :notes, :title, :permit, :primary_crew_id, :plot_plans, :drawings, :option, :ready_to_process, permit_information_attributes: [:valuation, :replacement, :units, :type_of_replacement, :amount, :engineering, :engineer_id ])
    end

    def contracts
      @contracts = Contract.unprojected_contracts
      @contracts << @project.try(:contract) if @project and @project.contract_id
    end

    def create_documents
      if params[:document_attributes].present?
        params[:document_attributes].each do |file|
          @project.documents << Document.new(attachment: file)
        end
      end
    end
end
