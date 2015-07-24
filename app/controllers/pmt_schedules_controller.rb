class PmtSchedulesController < ApplicationController
  before_action :set_pmt_schedule, only: [:show, :edit, :update, :destroy]

  # GET /pmt_schedules
  # GET /pmt_schedules.json
  def index
    @pmt_schedules = PmtSchedule.all
  end

  # GET /pmt_schedules/1
  # GET /pmt_schedules/1.json
  def show
  end

  # GET /pmt_schedules/new
  def new
    @pmt_schedule = PmtSchedule.new
  end

  # GET /pmt_schedules/1/edit
  def edit
  end

  # POST /pmt_schedules
  # POST /pmt_schedules.json
  def create
    @pmt_schedule = PmtSchedule.new(pmt_schedule_params)

    respond_to do |format|
      if @pmt_schedule.save
        format.html { redirect_to @pmt_schedule, notice: 'Pmt schedule was successfully created.' }
        format.json { render :show, status: :created, location: @pmt_schedule }
      else
        format.html { render :new }
        format.json { render json: @pmt_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pmt_schedules/1
  # PATCH/PUT /pmt_schedules/1.json
  def update
    respond_to do |format|
      if @pmt_schedule.update(pmt_schedule_params)
        format.html { redirect_to @pmt_schedule, notice: 'Pmt schedule was successfully updated.' }
        format.json { render :show, status: :ok, location: @pmt_schedule }
      else
        format.html { render :edit }
        format.json { render json: @pmt_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pmt_schedules/1
  # DELETE /pmt_schedules/1.json
  def destroy
    @pmt_schedule.destroy
    respond_to do |format|
      format.html { redirect_to pmt_schedules_url, notice: 'Pmt schedule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pmt_schedule
      @pmt_schedule = PmtSchedule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pmt_schedule_params
      params.require(:pmt_schedule).permit(:contract_id, :pmtNumber, :pmtDate, :pmtAmount)
    end
end
