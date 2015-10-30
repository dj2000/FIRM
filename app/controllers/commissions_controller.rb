class CommissionsController < ApplicationController
  before_action :set_commission, only: [:show, :edit, :update, :destroy]
  before_action :inspectors_and_commission_rates

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

  private
    def set_commission
      @commission = Commission.find(params[:id])
    end

    def commission_params
      params.require(:commission).permit(:inspector_id, :commission_rate_id, :percentage)
    end

    def inspectors_and_commission_rates
      @inspectors = Inspector.all
      @commission_rates = CommissionRate.all
    end
end
