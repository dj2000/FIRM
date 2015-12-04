class PermitsController < ApplicationController
  before_action :set_permit, only: [:show, :edit, :update, :destroy]
  before_action :permitted_projects
  before_action :role_required

  # GET /permits
  # GET /permits.json
  def index
    @permits = Permit.all
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data Permit.as_csv }
    end
  end

  # GET /permits/1
  # GET /permits/1.json
  def show
  end

  # GET /permits/new
  def new
    @permit = Permit.new
  end

  # GET /permits/1/edit
  def edit
  end

  # POST /permits
  # POST /permits.json
  def create
    @permit = Permit.new(permit_params)

    respond_to do |format|
      if @permit.save
        format.html { redirect_to @permit, notice: 'Permit was successfully created.' }
        format.json { render :show, status: :created, location: @permit }
      else
        format.html { render :new }
        format.json { render json: @permit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /permits/1
  # PATCH/PUT /permits/1.json
  def update
    respond_to do |format|
      if @permit.update(permit_params)
        format.html { redirect_to @permit, notice: 'Permit was successfully updated.' }
        format.json { render :show, status: :ok, location: @permit }
      else
        format.html { render :edit }
        format.json { render json: @permit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /permits/1
  # DELETE /permits/1.json
  def destroy
    @permit.destroy
    respond_to do |format|
      format.html { redirect_to permits_url, notice: 'Permit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def print
    @permits = Permit.all
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_permit
      @permit = Permit.find(params[:id])
    end

    def permitted_projects
      @projects = Project.permitted_projects
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def permit_params
      params.require(:permit).permit(:reference, :project_id, :issueDate, :issuedBy, :status, :valuation)
    end
end
