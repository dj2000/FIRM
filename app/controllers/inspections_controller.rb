class InspectionsController < ApplicationController
  before_action :set_inspection, only: [:show, :edit, :update, :destroy]
  before_action :uninspected_appointments, only: [:edit, :update, :new, :create]

  # GET /inspections
  # GET /inspections.json
  def index
    @inspections = Inspection.all
  end

  # GET /inspections/1
  # GET /inspections/1.json
  def show
    @bids = @inspection.bids
  end

  # GET /inspections/new
  def new
    @inspection = Inspection.new
  end

  # GET /inspections/1/edit
  def edit
  end

  # POST /inspections
  # POST /inspections.json
  def create
    @inspection = Inspection.new(inspection_params)
    create_documents
    respond_to do |format|
      if @inspection.save
        format.html { redirect_to @inspection, notice: 'Inspection was successfully created.' }
        format.json { render json: @inspection }
      else
        format.html { render :new }
        format.json { render json: @inspection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inspections/1
  # PATCH/PUT /inspections/1.json
  def update
    create_documents
    respond_to do |format|
      if @inspection.update(inspection_params)
        format.html { redirect_to @inspection, notice: 'Inspection was successfully updated.' }
        format.json { render :show, status: :ok, location: @inspection }
      else
        format.html { render :edit }
        format.json { render json: @inspection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inspections/1
  # DELETE /inspections/1.json
  def destroy
    @inspection.destroy
    respond_to do |format|
      format.html { redirect_to inspections_url, notice: 'Inspection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def appointment_info
    @appointment = Appointment.find(params[:id])
    @insp_request = @appointment.insp_request
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inspection
      @inspection = Inspection.find(params[:id])
    end

    def uninspected_appointments
      @appointments = Appointment.uninspected_appointments || []
      @appointments << @inspection.try(:appointment) if @inspection
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inspection_params
      params.require(:inspection).permit(:fCondition, :businessCards, :nOD, :nOG, :paid, :reportURL, :footprintURL, :repairs, :permit, :interiorAccess, :verifiedReport, :verifiedComp, :notes, :name, :appointment_id, :report, :completed_appointment_sheet, :client_information_sheet, :footprint_diagram, bids_attributes: [:id, :costRepair, :feeSeismicUpg, :feeAdmin,  :_destroy])
    end

    def create_documents
      if params[:document_attributes].present?
        params[:document_attributes].each do |file|
          @inspection.documents << Document.new(attachment: file)
        end
      end
    end
end
