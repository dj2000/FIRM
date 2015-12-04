class CommissionsController < ApplicationController
  before_action :set_commission, only: [:show, :edit, :update, :destroy]
  before_action :inspectors_and_commission_rates
  before_action :role_required
  respond_to :html

  def index
    @commissions = Commission.all
    respond_with(@commissions)
  end

  def show
    respond_with(@commission)
  end

  def new
    @commission = Commission.new
    respond_with(@commission)
  end

  def edit
  end

  def create
    @commission = Commission.new(commission_params)
    @commission.save
    respond_with(@commission)
  end

  def update
    @commission.update(commission_params)
    respond_with(@commission)
  end

  def destroy
    @commission.destroy
    respond_with(@commission)
  end

  def process_commissions
    @inspectors = @inspectors.map{|i| [i.name, i.id]}
    @date = (Date.today - 7.days).beginning_of_week
  end

  def calculation_of_inspector_commissions
    inspector_commission
    respond_to do |format|
      format.js
      format.html
    end
  end

  def print
    inspector_commission
    respond_to do |format|
      format.js
    end
  end

  def inspector_commission
    @start = params[:commission_period_date].to_date.beginning_of_week
    @end = params[:commission_period_date].to_date.end_of_week(:saturday)
    if params[:inspector].present?
      @inspector = Inspector.find(params[:inspector])
      @records = Contract.calculate_commissions(@start, @end, params[:inspector])
      @total = 0
      @commission_payment_details = Array.new
      @records.each do |contract_id, record|
        commission_payment_detail = CommissionPaymentDetail.where(contract_id: contract_id, inspector_id: params[:inspector]).first_or_create
        commission_payment_detail.update(commission_rate: record["rate"], amount: record["commission"], project_cost: record["total_sales_amount"], paid_date: record["paid_date"])
        @commission_payment_details << commission_payment_detail
        @total += record["commission"]
      end
    end
  end

  private
    def set_commission
      @commission = Commission.find(params[:id])
    end

    def commission_params
      params.require(:commission).permit(:inspector_id, :commission_rate_id, :percentage)
    end

    def inspectors_and_commission_rates
      @inspectors = Inspector.all
      @commission_rates = CommissionRate.all.order(:created_at)
    end
end
