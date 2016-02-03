class IFeeSchedulesController < ApplicationController
  before_action :set_i_fee_schedule, only: [:show, :edit, :update, :destroy]

  # GET /i_fee_schedules
  # GET /i_fee_schedules.json
  def index
    @i_fee_schedules = IFeeSchedule.all.paginate(page: params[:page])
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data IFeeSchedule.as_csv }
    end
  end

  # GET /i_fee_schedules/1
  # GET /i_fee_schedules/1.json
  def show
  end

  # GET /i_fee_schedules/new
  def new
    @i_fee_schedule = IFeeSchedule.new
  end

  # GET /i_fee_schedules/1/edit
  def edit
  end

  # POST /i_fee_schedules
  # POST /i_fee_schedules.json
  def create
    @i_fee_schedule = IFeeSchedule.new(i_fee_schedule_params)

    respond_to do |format|
      if @i_fee_schedule.save
        format.html { redirect_to @i_fee_schedule, notice: 'Fee Schedule was successfully created.' }
        format.json { render :show, status: :created, location: @i_fee_schedule }
      else
        format.html { render :new }
        format.json { render json: @i_fee_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /i_fee_schedules/1
  # PATCH/PUT /i_fee_schedules/1.json
  def update
    respond_to do |format|
      if @i_fee_schedule.update(i_fee_schedule_params)
        format.html { redirect_to @i_fee_schedule, notice: 'Fee Schedule was successfully updated.' }
        format.json { render :show, status: :ok, location: @i_fee_schedule }
      else
        format.html { render :edit }
        format.json { render json: @i_fee_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /i_fee_schedules/1
  # DELETE /i_fee_schedules/1.json
  def destroy
    @i_fee_schedule.destroy
    respond_to do |format|
      format.html { redirect_to i_fee_schedules_url, notice: 'Fee Schedule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def print
    @i_fee_schedules = IFeeSchedule.all.paginate(page: params[:page])
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_i_fee_schedule
      @i_fee_schedule = IFeeSchedule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def i_fee_schedule_params
      params.require(:i_fee_schedule).permit(:feeActive, :effectiveFrom, :ownerOccRate, :sfrBaseRate, :sfrIncRate, :mfrBaseRate, :mfrIncRate, :insBaseRate, :insIncRate)
    end
end
