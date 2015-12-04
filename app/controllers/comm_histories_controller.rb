class CommHistoriesController < ApplicationController
  before_action :set_comm_history, only: [:show, :edit, :update, :destroy]
  before_action :bids
  before_action :role_required

  # GET /comm_histories
  # GET /comm_histories.json
  def index
    @bid = Bid.find(params[:id]) if params[:id]
    if params[:client_id].present? || params[:property_id].present?
      if params[:search_filter] == "Property"
        @comm_histories = CommHistory.joins(:bid => [:inspection => [:appointment => :insp_request]]).where("insp_requests.property_id = ? ", params[:property_id])
      elsif params[:search_filter] == "Client"
        @comm_histories = CommHistory.joins(:bid => [:inspection => [:appointment => :insp_request]]).where("insp_requests.client_id = ? ", params[:client_id])
      end
    else
      @comm_histories = @bid ? @bid.comm_histories : CommHistory.all
    end
    @properties = Property.all.map{|p| [p.property_select_value, p.id]}
    @clients = Client.all.map{|c| [c.name, c.id]}
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /comm_histories/1
  # GET /comm_histories/1.json
  def show
  end

  # GET /comm_histories/new
  def new
    @comm_history = CommHistory.new
  end

  # GET /comm_histories/1/edit
  def edit
  end

  # POST /comm_histories
  # POST /comm_histories.json
  def create
    @comm_history = CommHistory.new(comm_history_params)
    respond_to do |format|
      if @comm_history.save
        format.html { redirect_to @comm_history, notice: 'Bids follow up was successfully created.' }
        format.json { render :show, status: :created, location: @comm_history }
      else
        format.html { render :new }
        format.json { render json: @comm_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comm_histories/1
  # PATCH/PUT /comm_histories/1.json
  def update
    respond_to do |format|
      if @comm_history.update(comm_history_params)
        format.html { redirect_to @comm_history, notice: 'Bids follow up was successfully updated.' }
        format.json { render :show, status: :ok, location: @comm_history }
      else
        format.html { render :edit }
        format.json { render json: @comm_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comm_histories/1
  # DELETE /comm_histories/1.json
  def destroy
    @comm_history.destroy
    respond_to do |format|
      format.html { redirect_to comm_histories_url, notice: 'Bids follow up was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comm_history
      @comm_history = CommHistory.find(params[:id])
      @bid = @comm_history.try(:bid)
    end

    def bids
      @bids = Bid.where("status = ? OR status = ? ", "Pending", "Follow-up")
      @bids << @comm_history.try(:bid) if @comm_history and @comm_history.bid_id
      @bids = @bids.map{|b| [b.try(:title), b.id]}
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comm_history_params
      update_bid if params[:comm_history][:bid_id].present?
      params.require(:comm_history).permit(:caller, :recipient, :callSummary, :callOutcome, :callBackDate, :notes, :bid_id, :call_time)
    end

    def update_bid
      @bid = Bid.find(params[:comm_history][:bid_id])
      case params[:comm_history][:callOutcome]
      when "Verbal Close"
        status = "Accepted"
      when "Not Interested"
        status = "Declined"
      when "Follow-up"
        status = "Follow-up"
      end
      @bid.update(status: status)
      params[:comm_history][:callBackDate] = "" unless params[:comm_history][:callOutcome] == "Follow-up"
    end
end
