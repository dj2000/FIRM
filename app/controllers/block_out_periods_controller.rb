class BlockOutPeriodsController < ApplicationController
	before_action :inspectors
	before_action :set_block_out_period, only: [:edit, :update]

  def index
		@block_out_periods = BlockOutPeriod.all
		@block_out_period = BlockOutPeriod.new
		respond_to do |format|
		  format.html
		  format.json{ render json: @block_out_periods.as_json }
		end
  end

  def new
		@block_out_period = BlockOutPeriod.new
  end

  def create
    @block_out_period = BlockOutPeriod.new(block_out_period_params)
    @block_out_period.save
  end

  def edit
  end

  def update
		@block_out_period.update(block_out_period_params)
  end

  private

  def block_out_period_params
		params[:block_out_period][:schedStart] = params[:schedStart].join(" ").to_datetime
    params[:block_out_period][:schedEnd] = params[:schedEnd].join(" ").to_datetime
    params.require(:block_out_period).permit(:schedStart, :schedEnd, :allDay, :inspector_id)
  end

  def inspectors
    @inspectors = Inspector.all.map{|i| [i.firstName, i.id]}
  end

  def set_block_out_period
    @block_out_period = BlockOutPeriod.find(params[:id])
  end
end
