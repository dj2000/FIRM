class ContractsController < ApplicationController
  before_action :set_contract, only: [:show, :edit, :update, :destroy]
  before_action :bids

  # GET /contracts
  # GET /contracts.json
  def index
    if params[:client_id].present? || params[:property_id].present?
      if params[:search_filter] == "Property"
        @contracts = Contract.joins(:bid => [:inspection => [:appointment => :insp_request]]).where("insp_requests.property_id = ? ", params[:property_id])
      elsif params[:search_filter] == "Client"
        @contracts = Contract.joins(:bid => [:inspection => [:appointment => :insp_request]]).where("insp_requests.client_id = ? ", params[:client_id])
      end
    else
      @contracts = Contract.all
    end
    @properties = Property.all.map{|p| [p.property_select_value, p.id]}
    @clients = Client.all.map{|c| [c.name, c.id]}
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /contracts/1
  # GET /contracts/1.json
  def show
  end

  # GET /contracts/new
  def new
    @contract = Contract.new
  end

  # GET /contracts/1/edit
  def edit
  end

  # POST /contracts
  # POST /contracts.json
  def create
    @contract = Contract.new(contract_params)

    respond_to do |format|
      if @contract.save
        format.html { redirect_to @contract, notice: 'Contract was successfully created.' }
        format.json { render :show, status: :created, location: @contract }
      else
        format.html { render :new }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contracts/1
  # PATCH/PUT /contracts/1.json
  def update
    respond_to do |format|
      if @contract.update(contract_params)
        format.html { redirect_to @contract, notice: 'Contract was successfully updated.' }
        format.json { render :show, status: :ok, location: @contract }
      else
        format.html { render :edit }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  def report_result
    contractdate = Date.parse(params[:contract_date])
    @contracts = Contract.where("date >= ?", contractdate)
  end

  def print
    contractdate = Date.parse(params[:contract_date])
    @contracts = Contract.where("date >= ?", contractdate)
  end

  # DELETE /contracts/1
  # DELETE /contracts/1.json
  def destroy
    @contract.destroy
    respond_to do |format|
      format.html { redirect_to contracts_url, notice: 'Contract was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contract
      @contract = Contract.find(params[:id])
      @bid = @contract.try(:bid)
    end

    def bids
      @uncontracted_bids = Bid.uncontracted_bids
      @accepted_bids = Bid.accepted_bids
      @bids = @uncontracted_bids + @accepted_bids
      @bids << @contract.try(:bid) if @contract and @contract.bid_id
      @bids = @bids.map{|b| [b.try(:title), b.id]}.uniq
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contract_params
      update_params
      params.require(:contract).permit(:bid_id, :payPlan_id, :date, :signedBy, :acceptedBy, :dateSigned, :downPmtAmt, :downPmtDate, :confirmed_by, :accepted, :accepted_date, :signed, :down_payment, :title)
    end

    def update_params
      params[:contract][:downPmtAmt] = params[:contract][:downPmtAmt].gsub("$","").to_i if params[:contract][:down_payment] == "1"
      params[:contract][:acceptedBy] = params[:contract][:accepted_date] = nil if params[:contract][:accepted] == "0" || params[:contract][:accepted] == ""
      params[:contract][:dateSigned] = params[:contract][:signedBy] = nil if params[:contract][:signed] == "0" || params[:contract][:signed] == ""
      params[:contract][:downPmtDate] = params[:contract][:downPmtAmt] = nil if params[:contract][:down_payment] == "0" || params[:contract][:down_payment] == ""
    end
end
