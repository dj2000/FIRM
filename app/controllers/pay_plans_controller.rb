class PayPlansController < ApplicationController
  before_action :set_pay_plan, only: [:show, :edit, :update, :destroy]

  # GET /pay_plans
  # GET /pay_plans.json
  def index
    @pay_plans = PayPlan.all
  end

  # GET /pay_plans/1
  # GET /pay_plans/1.json
  def show
  end

  # GET /pay_plans/new
  def new
    @pay_plan = PayPlan.new
  end

  # GET /pay_plans/1/edit
  def edit
  end

  # POST /pay_plans
  # POST /pay_plans.json
  def create
    @pay_plan = PayPlan.new(pay_plan_params)

    respond_to do |format|
      if @pay_plan.save
        format.html { redirect_to @pay_plan, notice: 'Pay plan was successfully created.' }
        format.json { render :show, status: :created, location: @pay_plan }
      else
        format.html { render :new }
        format.json { render json: @pay_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pay_plans/1
  # PATCH/PUT /pay_plans/1.json
  def update
    respond_to do |format|
      if @pay_plan.update(pay_plan_params)
        format.html { redirect_to @pay_plan, notice: 'Pay plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @pay_plan }
      else
        format.html { render :edit }
        format.json { render json: @pay_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pay_plans/1
  # DELETE /pay_plans/1.json
  def destroy
    @pay_plan.destroy
    respond_to do |format|
      format.html { redirect_to pay_plans_url, notice: 'Pay plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pay_plan
      @pay_plan = PayPlan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pay_plan_params
      params.require(:pay_plan).permit(:jobMinAmt, :jobMaxAmt, :pmt1Pcnt, :pmt2Pcnt, :pmt3Pcnt, :pmt4Pcnt, :pmt5Pcnt, :pmt1Desc, :pmt2Desc, :pmt3Desc, :pmt4Desc, :pmt5Desc)
    end
end
