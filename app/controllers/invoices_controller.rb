class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]
  before_action :projects_inspections
  before_action :role_required, except: [:report]

  # GET /invoices
  # GET /invoices.json
  def index
    @invoices = Invoice.all
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
  end

  # GET /invoices/new
  def new
    @invoice = Invoice.new
  end

  # GET /invoices/1/edit
  def edit
  end

  # POST /invoices
  # POST /invoices.json
  def create
    @invoice = Invoice.new(invoice_params)

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to @invoice, notice: 'Invoice was successfully created.' }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoices/1
  # PATCH/PUT /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to @invoice, notice: 'Invoice was successfully updated.' }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to invoices_url, notice: 'Invoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def info
    @attribute = params[:attribute]
    instance_variable_set("@#{@attribute}", @attribute.camelize.constantize.find(params[:id]))
    @bid = @project.try(:contract).try(:bid)
    @inspection = (@inspection || @bid.try(:inspection))
    respond_to do |format|
      format.js
    end
  end

  def get_report
    get_invoice_report
    respond_to do |format|
      format.js
    end
  end

  def get_invoice_report
    @invoice_type = params[:invoice_type].camelize
    start_date = params[:start_date].to_date
    end_date = params[:end_date].to_date
    @invoices = Invoice.where(invoice_type: @invoice_type).where('"invoiceDate" BETWEEN ? AND ? ', start_date, end_date).paginate(page: params[:page])
  end

  def print
    get_invoice_report
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    def projects_inspections
      @projects = Project.all.map{|p| [p.title, p.id]}
      @inspections = Inspection.all.map{|p| [p.name, p.id]}
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_params
      params.require(:invoice).permit(:reference, :invoice_type, :inspection_id, :project_id, :description, :invoiceDate, :amount, :due_date, :balanceDue)
    end
end
