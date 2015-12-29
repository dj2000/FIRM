class InspectionsController < ApplicationController
  before_action :set_inspection, only: [:show, :edit, :update, :destroy, :send_email]
  before_action :uninspected_appointments, only: [:edit, :update, :new, :create]

  # GET /inspections
  # GET /inspections.json
  def index
    if params[:client_id].present? || params[:property_id].present?
      if params[:search_filter] == "Property"
        @inspections = Inspection.joins(:appointment => :insp_request).where("insp_requests.property_id = ? ", params[:property_id])
      elsif params[:search_filter] == "Client"
        @inspections = Inspection.joins(:appointment => :insp_request).where("insp_requests.client_id = ? ", params[:client_id])
      end
    else
      @inspections = Inspection.all
    end
    @properties = Property.all.map{|p| [p.property_select_value, p.id]}
    @clients = Client.all.map{|c| [c.name, c.id]}
    respond_to do |format|
      format.js
      format.csv { send_data Inspection.to_csv }
      format.html
    end
  end

  # GET /inspections/1
  # GET /inspections/1.json
  def show
    @file_urls = params[:file_urls].split(",") if params[:file_urls].present?
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
    respond_to do |format|
      if @inspection.save
        create_documents
        format.js
        format.html { redirect_to @inspection, notice: 'Inspection was successfully created.' }
      else
        format.html { render :new }
        format.js
      end
    end
  end

  # PATCH/PUT /inspections/1
  # PATCH/PUT /inspections/1.json
  def update
    respond_to do |format|
      if @inspection.update(inspection_params)
        create_documents
        format.js
        format.html { redirect_to @inspection, notice: 'Inspection was successfully updated.' }
      else
        format.html { render :edit }
        format.js
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
    @clients = @insp_request.try(:property).try(:clients)
    respond_to do |format|
      format.js
    end
  end

  def print
    if URI(request.referer).path == "/inspections/report"
      start_date = DateTime.parse(params[:start_date])
      end_date = DateTime.parse(params[:end_date])
      @inspections = Inspection.created_between(start_date, end_date)
    else
      @inspections = Inspection.all
    end
    respond_to do |format|
      format.js
    end
  end

  def report_result
    start_date = DateTime.parse(params[:start_date])
    end_date = DateTime.parse(params[:end_date])
    @inspections = Inspection.created_between(start_date, end_date)
  end

  def send_email
    file_name = params[:bid_name].gsub(",", "_").gsub(" ", "_")
    file_urls = params[:file_urls].split(",") if params[:file_urls].present?
    client = Client.find(params[:client_id])
    call_summary = params[:call_summary].gsub("\n", "<br>")
    directory = Rails.root.join("public", "pdfs")
    Dir.mkdir(directory) unless File.directory?(directory)
    pdf_directory = Rails.root.join(directory, "#{@inspection.try(:id)}" )
    Dir.mkdir(pdf_directory) unless File.directory?(pdf_directory)
    save_path = Rails.root.join(pdf_directory, "#{file_name}.pdf")
    pdf = WickedPdf.new.pdf_from_string(call_summary, formats: :html, encoding: 'utf8')
    File.open(save_path, 'wb') do |file|
      file << pdf
      @inspection.documents << Document.create(document_type: "email", attachment: file)
    end
    UserMailer.send_call_summary_to_client(client, call_summary, file_urls, file_name).deliver
    render json: @inspection
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inspection
      @inspection = Inspection.find(params[:id])
      @documents = @inspection.try(:documents)
      @clients = @inspection.try(:appointment).try(:insp_request).try(:property).try(:clients)
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
      [:document_attributes, :email_document_attributes].each do |attribute|
        params_values =  params["#{attribute}".to_sym]
        document_type = (attribute.to_sym == :email_document_attributes ) ? 'email' : nil
        if params_values.present?
          params_values.each do |file|
            @inspection.documents << Document.new(attachment: file, document_type: document_type )
          end
        end
      end
    end
end
