class ReceiptsController < ApplicationController
  before_action :set_receipt, only: [:show, :edit, :update, :destroy]
  before_action :invoices
  # GET /receipts
  # GET /receipts.json
  def index
    @receipts = Receipt.all.order(:created_at)
  end

  # GET /receipts/1
  # GET /receipts/1.json
  def show
  end

  # GET /receipts/new
  def new
    @receipt = Receipt.new
  end

  # GET /receipts/1/edit
  def edit
  end

  # POST /receipts
  # POST /receipts.json
  def create
    @receipt = Receipt.new(receipt_params)

    respond_to do |format|
      if @receipt.save
        format.html { redirect_to @receipt, notice: 'Receipt was successfully created.' }
        format.json { render :show, status: :created, location: @receipt }
      else
        format.html { render :new }
        format.json { render json: @receipt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /receipts/1
  # PATCH/PUT /receipts/1.json
  def update
    respond_to do |format|
      if @receipt.update(receipt_params)
        format.html { redirect_to @receipt, notice: 'Receipt was successfully updated.' }
        format.json { render :show, status: :ok, location: @receipt }
      else
        format.html { render :edit }
        format.json { render json: @receipt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /receipts/1
  # DELETE /receipts/1.json
  def destroy
    @receipt.destroy
    respond_to do |format|
      format.html { redirect_to receipts_url, notice: 'Receipt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def invoice_info
    @invoice = Invoice.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def report_result
    start_date = DateTime.parse(params[:start_date])
    end_date = DateTime.parse(params[:end_date])
    @receipts = Receipt.where('("date" BETWEEN ? AND ?)',start_date, end_date)
  end

  def print
    start_date = DateTime.parse(params[:start_date])
    end_date = DateTime.parse(params[:end_date])
    @receipts = Receipt.where('("date" BETWEEN ? AND ?)',start_date, end_date)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_receipt
      @receipt = Receipt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def receipt_params
      params[:receipt][:invoice_amount] = params[:invoice][:amount]
      params.require(:receipt).permit(:reference, :date, :invoice_id, :amount, :recBy, :invoice_amount)
    end

    def invoices
      @invoices = Invoice.all.where.not(amount: 0.0)
      @invoices << @receipt.try(:invoice) if @receipt and @invoices
    end
end
