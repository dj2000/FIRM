class SvcAreasController < ApplicationController
  before_action :set_svc_area, only: [:show, :edit, :update, :destroy]

  # GET /svc_areas
  # GET /svc_areas.json
  def index
    @svc_areas = SvcArea.all
  end

  # GET /svc_areas/1
  # GET /svc_areas/1.json
  def show
  end

  # GET /svc_areas/new
  def new
    @svc_area = SvcArea.new
  end

  # GET /svc_areas/1/edit
  def edit
  end

  # POST /svc_areas
  # POST /svc_areas.json
  def create
    @svc_area = SvcArea.new(svc_area_params)

    respond_to do |format|
      if @svc_area.save
        format.html { redirect_to @svc_area, notice: 'Svc area was successfully created.' }
        format.json { render :show, status: :created, location: @svc_area }
      else
        format.html { render :new }
        format.json { render json: @svc_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /svc_areas/1
  # PATCH/PUT /svc_areas/1.json
  def update
    respond_to do |format|
      if @svc_area.update(svc_area_params)
        format.html { redirect_to @svc_area, notice: 'Svc area was successfully updated.' }
        format.json { render :show, status: :ok, location: @svc_area }
      else
        format.html { render :edit }
        format.json { render json: @svc_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /svc_areas/1
  # DELETE /svc_areas/1.json
  def destroy
    @svc_area.destroy
    respond_to do |format|
      format.html { redirect_to svc_areas_url, notice: 'Svc area was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_svc_area
      @svc_area = SvcArea.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def svc_area_params
      params.require(:svc_area).permit(:zip, :city, :state, :serviced)
    end
end
