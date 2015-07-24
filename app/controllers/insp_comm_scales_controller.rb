class InspCommScalesController < ApplicationController
  before_action :set_insp_comm_scale, only: [:show, :edit, :update, :destroy]

  # GET /insp_comm_scales
  # GET /insp_comm_scales.json
  def index
    @insp_comm_scales = InspCommScale.all
  end

  # GET /insp_comm_scales/1
  # GET /insp_comm_scales/1.json
  def show
  end

  # GET /insp_comm_scales/new
  def new
    @insp_comm_scale = InspCommScale.new
  end

  # GET /insp_comm_scales/1/edit
  def edit
  end

  # POST /insp_comm_scales
  # POST /insp_comm_scales.json
  def create
    @insp_comm_scale = InspCommScale.new(insp_comm_scale_params)

    respond_to do |format|
      if @insp_comm_scale.save
        format.html { redirect_to @insp_comm_scale, notice: 'Insp comm scale was successfully created.' }
        format.json { render :show, status: :created, location: @insp_comm_scale }
      else
        format.html { render :new }
        format.json { render json: @insp_comm_scale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /insp_comm_scales/1
  # PATCH/PUT /insp_comm_scales/1.json
  def update
    respond_to do |format|
      if @insp_comm_scale.update(insp_comm_scale_params)
        format.html { redirect_to @insp_comm_scale, notice: 'Insp comm scale was successfully updated.' }
        format.json { render :show, status: :ok, location: @insp_comm_scale }
      else
        format.html { render :edit }
        format.json { render json: @insp_comm_scale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /insp_comm_scales/1
  # DELETE /insp_comm_scales/1.json
  def destroy
    @insp_comm_scale.destroy
    respond_to do |format|
      format.html { redirect_to insp_comm_scales_url, notice: 'Insp comm scale was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_insp_comm_scale
      @insp_comm_scale = InspCommScale.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def insp_comm_scale_params
      params.require(:insp_comm_scale).permit(:inspector_id, :scaleStart, :scaleEnd, :rate)
    end
end
