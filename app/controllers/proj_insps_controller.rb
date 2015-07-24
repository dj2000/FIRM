class ProjInspsController < ApplicationController
  before_action :set_proj_insp, only: [:show, :edit, :update, :destroy]

  # GET /proj_insps
  # GET /proj_insps.json
  def index
    @proj_insps = ProjInsp.all
  end

  # GET /proj_insps/1
  # GET /proj_insps/1.json
  def show
  end

  # GET /proj_insps/new
  def new
    @proj_insp = ProjInsp.new
  end

  # GET /proj_insps/1/edit
  def edit
  end

  # POST /proj_insps
  # POST /proj_insps.json
  def create
    @proj_insp = ProjInsp.new(proj_insp_params)

    respond_to do |format|
      if @proj_insp.save
        format.html { redirect_to @proj_insp, notice: 'Proj insp was successfully created.' }
        format.json { render :show, status: :created, location: @proj_insp }
      else
        format.html { render :new }
        format.json { render json: @proj_insp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /proj_insps/1
  # PATCH/PUT /proj_insps/1.json
  def update
    respond_to do |format|
      if @proj_insp.update(proj_insp_params)
        format.html { redirect_to @proj_insp, notice: 'Proj insp was successfully updated.' }
        format.json { render :show, status: :ok, location: @proj_insp }
      else
        format.html { render :edit }
        format.json { render json: @proj_insp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proj_insps/1
  # DELETE /proj_insps/1.json
  def destroy
    @proj_insp.destroy
    respond_to do |format|
      format.html { redirect_to proj_insps_url, notice: 'Proj insp was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_proj_insp
      @proj_insp = ProjInsp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def proj_insp_params
      params.require(:proj_insp).permit(:project_id, :reference, :scheduleDate, :inspectBy, :completeDate, :result)
    end
end
