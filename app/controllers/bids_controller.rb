class BidsController < ApplicationController
	before_action :payment_plans
  before_action :set_bid, only: [:show, :edit, :update, :destroy]
  before_action :format_amount, only: [:create, :update]

  # GET /bids
  # GET /bids.json
  def index
    if params[:start_date].present? and params[:end_date].present?
      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])
      @bids = Bid.created_between(start_date, end_date).paginate(page: params[:page])
    else
      @bids = Bid.all.paginate(page: params[:page])
    end
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /bids/1
  # GET /bids/1.json
  def show
  end

  # GET /bids/new
  def new
    @bid = Bid.new
    @inspection = Inspection.find(params[:inspection_id])
  end

  # GET /bids/1/edit
  def edit
  end

  # POST /bids
  # POST /bids.json
  def create
    @bid = Bid.new(bid_params)
    @inspection = @bid.try(:inspection)
    @bids = @inspection.try(:bids)
    respond_to do |format|
      if @bid.save
        format.html { redirect_to @bid, notice: 'Bid was successfully created.' }
        format.js
      else
        format.html { render :new }
        format.js
      end
    end
  end

  # PATCH/PUT /bids/1
  # PATCH/PUT /bids/1.json
  def update
    respond_to do |format|
      if @bid.update(bid_params)
        format.html { redirect_to @bid, notice: 'Bid was successfully updated.' }
        format.js
      else
        format.html { render :edit }
        format.js
      end
    end
  end

  # DELETE /bids/1
  # DELETE /bids/1.json
  def destroy
    @bid.destroy
    respond_to do |format|
      format.html { redirect_to bids_url, notice: 'Bid was successfully destroyed.' }
      format.js
    end
  end

  def print
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])
    @bids = Bid.created_between(start_date, end_date)
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bid
      @bid = Bid.find(params[:id])
      @inspection = @bid.try(:inspection)
      @bids = @inspection.try(:bids)
    end

    def payment_plans
      @payment_plans = PayPlan.all
    end

    def format_amount
      params[:bid][:costRepair] = params[:bid][:costRepair].gsub("$","").to_i
      params[:bid][:feeSeismicUpg] = params[:bid][:feeSeismicUpg].gsub("$","").to_i
      params[:bid][:feeAdmin] = params[:bid][:feeAdmin].gsub("$","").to_i
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bid_params
      params.require(:bid).permit(:inspection_id, :costRepair, :feeSeismicUpg, :feeAdmin, :payPlan_id, :status, :title)
    end
end
