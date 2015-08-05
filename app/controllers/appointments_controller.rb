class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]

  # GET /appointments
  # GET /appointments.json
  def index
    @appointments = Appointment.all
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments
  # POST /appointments.json
  def create
    inspectors
    @appointment = Appointment.new(appointment_params)
    @insp_request = @appointment.insp_request
    @appointment.save
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    inspectors
    @insp_request = @appointment.insp_request
    @appointment.update(appointment_params)
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to appointments_url, notice: 'Appointment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def schedule_inspection
    @insp_request = InspRequest.find(params[:id])
    @appointment = @insp_request.appointment || @insp_request.build_appointment
    @appointment.save(validate: false)
    inspectors
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    def inspectors
      @inspectors = Inspector.all.map{|i| [i.firstName, i.id]}
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_params
      params.require(:appointment).permit(:inspRequest_id, :schedStart, :schedEnd, :allDay, :inspector_id, :contact, :inspFee, :prepaid, :pmtMethod, :pmtRef, :notes, :amount_received, :scheduled_inspection)
    end
end