require 'test_helper'

class PayPlansControllerTest < ActionController::TestCase
  setup do
    @pay_plan = pay_plans(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pay_plans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pay_plan" do
    assert_difference('PayPlan.count') do
      post :create, pay_plan: { jobMaxAmt: @pay_plan.jobMaxAmt, jobMinAmt: @pay_plan.jobMinAmt, pmt1Desc: @pay_plan.pmt1Desc, pmt1Pcnt: @pay_plan.pmt1Pcnt, pmt2Desc: @pay_plan.pmt2Desc, pmt2Pcnt: @pay_plan.pmt2Pcnt, pmt3Desc: @pay_plan.pmt3Desc, pmt3Pcnt: @pay_plan.pmt3Pcnt, pmt4Desc: @pay_plan.pmt4Desc, pmt4Pcnt: @pay_plan.pmt4Pcnt, pmt5Desc: @pay_plan.pmt5Desc, pmt5Pcnt: @pay_plan.pmt5Pcnt }
    end

    assert_redirected_to pay_plan_path(assigns(:pay_plan))
  end

  test "should show pay_plan" do
    get :show, id: @pay_plan
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pay_plan
    assert_response :success
  end

  test "should update pay_plan" do
    patch :update, id: @pay_plan, pay_plan: { jobMaxAmt: @pay_plan.jobMaxAmt, jobMinAmt: @pay_plan.jobMinAmt, pmt1Desc: @pay_plan.pmt1Desc, pmt1Pcnt: @pay_plan.pmt1Pcnt, pmt2Desc: @pay_plan.pmt2Desc, pmt2Pcnt: @pay_plan.pmt2Pcnt, pmt3Desc: @pay_plan.pmt3Desc, pmt3Pcnt: @pay_plan.pmt3Pcnt, pmt4Desc: @pay_plan.pmt4Desc, pmt4Pcnt: @pay_plan.pmt4Pcnt, pmt5Desc: @pay_plan.pmt5Desc, pmt5Pcnt: @pay_plan.pmt5Pcnt }
    assert_redirected_to pay_plan_path(assigns(:pay_plan))
  end

  test "should destroy pay_plan" do
    assert_difference('PayPlan.count', -1) do
      delete :destroy, id: @pay_plan
    end

    assert_redirected_to pay_plans_path
  end
end
