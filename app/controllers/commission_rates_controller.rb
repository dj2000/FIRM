class CommissionRatesController < ApplicationController
  before_action :set_commission_rate, only: [:show, :edit, :update, :destroy]
  before_action :role_required
  # GET /commission_rates
  # GET /commission_rates.json
  def index
    @commission_rates = CommissionRate.all.order(:created_at).paginate(page: params[:page])
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data CommissionRate.as_csv }
    end
  end

  # GET /commission_rates/1
  # GET /commission_rates/1.json
  def show
  end

  # GET /commission_rates/new
  def new
    @commission_rate = CommissionRate.new
  end

  # GET /commission_rates/1/edit
  def edit
  end

  # POST /commission_rates
  # POST /commission_rates.json
  def create
    @commission_rate = CommissionRate.new(commission_rate_params)

    respond_to do |format|
      if @commission_rate.save
        format.html { redirect_to @commission_rate, notice: 'Commission rate was successfully created.' }
        format.json { render :show, status: :created, location: @commission_rate }
      else
        format.html { render :new }
        format.json { render json: @commission_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /commission_rates/1
  # PATCH/PUT /commission_rates/1.json
  def update
    respond_to do |format|
      if @commission_rate.update(commission_rate_params)
        format.html { redirect_to @commission_rate, notice: 'Commission rate was successfully updated.' }
        format.json { render :show, status: :ok, location: @commission_rate }
      else
        format.html { render :edit }
        format.json { render json: @commission_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commission_rates/1
  # DELETE /commission_rates/1.json
  def destroy
    @commission_rate.destroy
    respond_to do |format|
      format.html { redirect_to commission_rates_url, notice: 'Commission rate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def print
    @commission_rates = CommissionRate.all.order(:created_at)
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_commission_rate
      @commission_rate = CommissionRate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def commission_rate_params
      params[:commission_rate][:scale_start] = params[:commission_rate][:scale_start].gsub("$","").to_i if params[:commission_rate][:scale_start].present?
      params[:commission_rate][:scale_end] = params[:commission_rate][:scale_end].gsub("$","").to_i if params[:commission_rate][:scale_end].present?
      params.require(:commission_rate).permit(:scale_start, :scale_end, :title)
    end
end
