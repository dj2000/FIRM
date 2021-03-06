class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy, :print, :send_email]
  before_action :inspectors, only: [:create, :update, :schedule_inspection, :edit, :index ]
  before_action :role_required, except: [:report]
  # GET /appointments
  # GET /appointments.json
  def index
    @editable = false
    if params[:id]
      @insp_request = InspRequest.find(params[:id])
      @appointment = @insp_request.appointment || @insp_request.build_appointment
      @appointment.save(validate: false)
      @editable = true
    end
    if (params[:start_date] and params[:end_date])
      @appointments = Appointment.where('("schedStart" BETWEEN ? AND ?) OR ("schedEnd" BETWEEN ? AND ?)', params[:start_date], params[:end_date], params[:start_date], params[:end_date]).paginate(page: params[:page])
    else
      @appointments = Appointment.where.not(schedStart: nil, schedEnd: nil)
    end
    respond_to do |format|
      format.js
      format.html
      format.json{ render json: @appointments.as_json }
    end
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
    respond_to do |format|
      format.js
    end
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)
    @insp_request = @appointment.insp_request
    @appointment.save
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    @insp_request = @appointment.insp_request
    if params[:schedStart] and params[:schedEnd]
      params[:appointment][:schedStart] = params[:schedStart].join(" ").to_datetime
      params[:appointment][:schedEnd] = params[:schedEnd].join(" ").to_datetime
    end
    if params[:client_property]
      params[:client_property][:escrow] = false unless params[:client_property][:escrow]
      @client_property = ClientProperty.where(property_id: @insp_request.property_id, client_id: @insp_request.client_id).first_or_create
      @client_property.update(client_property_params)
    end
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

  def get_scheduled_appointments
    if params[:start_date] and params[:end_date]
      @start_day = params[:start_date]
      @end_day = params[:end_date]
    end
    @start_day = @start_day.to_datetime
    @end_day = @end_day.to_datetime
    @appointments =  Appointment.where('(("schedStart" BETWEEN ? AND ?) OR ("schedEnd" BETWEEN ? AND ?)) OR ("schedStart" >= ? OR "schedEnd" <= ? )', @start_day, @end_day, @start_day, @end_day, @start_day, @end_day)
    @appointments = @appointments.where(inspector_id: params[:inspector_id]) if params[:inspector_id].present?
    @block_out_periods = BlockOutPeriod.all
    @block_out_periods = @block_out_periods.where(inspector_id: params[:inspector_id]) if params[:inspector_id].present?
    response = { appointments: @appointments.as_json, block_out_periods: @block_out_periods.as_json }
    render json: response
  end

  def print
    @client_property = ClientProperty.where(property_id: @appointment.try(:insp_request).property_id, client_id: @appointment.try(:insp_request).client_id).first
    @agent_client = AgentClient.where(agent_id: @appointment.try(:insp_request).agent_id, client_id: @appointment.try(:insp_request).client_id).first
    respond_to do |format|
      format.js
    end
  end

  def report_print
    @appointments = Appointment.where('("schedStart" BETWEEN ? AND ?) OR ("schedEnd" BETWEEN ? AND ?)', params[:start_date], params[:end_date], params[:start_date], params[:end_date])
  end

  def send_email
    @client_property = ClientProperty.where(property_id: @appointment.try(:insp_request).property_id, client_id: @appointment.try(:insp_request).client_id).first
    @agent_client = AgentClient.where(agent_id: @appointment.try(:insp_request).agent_id, client_id: @appointment.try(:insp_request).client_id).first
    UserMailer.send_appointment(@appointment, @client_property, @agent_client, current_user.email).deliver
    respond_to do |format|
      format.js
    end
  end

  def calculate_inspection_fee
    @insp_request = InspRequest.find(params[:id])
    respond_to do |format|
      format.json{ render json: @insp_request.try(:calculate_inspection_fee, @insp_request.appointment, params[:is_insurance], :json) }
    end
  end

  ## To render default background events for appointments and block out periods
  def background_events
    @events = Array.new
    colors_hash = { "9:00" => "#D5B8EE", "11:30" => "FFFFFF", "14:00" => "#E5E7B6" }
    params[:start] = Date.parse(params[:start])
    params[:end] = Date.parse(params[:end])
    (params[:start]..params[:end]).each do |date|
      colors_hash.each do |time, event_color|
        start_date = "#{date} #{time}".to_datetime
        end_date = start_date + 2.hours + 30.minutes
        @events << { start: start_date, end: end_date, rendering: 'background', color: event_color}
      end
    end
    respond_to do |format|
      format.json{ render json: @events.as_json}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    def inspectors
      @inspectors = Inspector.active.map{|i| [i.firstName, i.id]}
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_params
      params.require(:appointment).permit(:inspRequest_id, :schedStart, :schedEnd, :allDay, :inspector_id, :contact, :inspFee, :prepaid, :pmtMethod, :pmtRef, :notes, :amount_received, :scheduled_inspection, :is_insurance, :concerns)
    end

    def client_property_params
      params.require(:client_property).permit(:property_id, :client_id, :escrow, :escrowDate)
    end
end