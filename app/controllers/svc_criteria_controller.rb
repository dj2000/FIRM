class SvcCriteriaController < ApplicationController
  before_action :set_svc_criterium, only: [:show, :edit, :update, :destroy]

  # GET /svc_criteria
  # GET /svc_criteria.json
  def index
    @svc_criteria = SvcCriterium.all
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data SvcCriterium.to_csv }
    end
  end

  # GET /svc_criteria/1
  # GET /svc_criteria/1.json
  def show
  end

  # GET /svc_criteria/new
  def new
    @svc_criterium = SvcCriterium.new
  end

  # GET /svc_criteria/1/edit
  def edit
  end

  # POST /svc_criteria
  # POST /svc_criteria.json
  def create
    @svc_criterium = SvcCriterium.new(svc_criterium_params)
    respond_to do |format|
      if @svc_criterium.save
        format.html { redirect_to @svc_criterium, notice: 'Service criterium was successfully created.' }
        format.json { render :show, status: :created, location: @svc_criterium }
      else
        format.html { render :new }
        format.json { render json: @svc_criterium.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /svc_criteria/1
  # PATCH/PUT /svc_criteria/1.json
  def update
    respond_to do |format|
      if @svc_criterium.update(svc_criterium_params)
        format.html { redirect_to @svc_criterium, notice: 'Service criterium was successfully updated.' }
        format.json { render :show, status: :ok, location: @svc_criterium }
      else
        format.html { render :edit }
        format.json { render json: @svc_criterium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /svc_criteria/1
  # DELETE /svc_criteria/1.json
  def destroy
    @svc_criterium.destroy
    respond_to do |format|
      format.html { redirect_to svc_criteria_url, notice: 'Svc criterium was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def print
    @svc_criteria = SvcCriterium.all
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_svc_criterium
      @svc_criterium = SvcCriterium.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def svc_criterium_params
      params.require(:svc_criterium).permit(:propRes, :propComm, :prevInsp, :hpoz, :cdo, :ownerOcc, :foundation, :yearBuilt, :notes)
    end
end
