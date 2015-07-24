require 'test_helper'

class PmtSchedulesControllerTest < ActionController::TestCase
  setup do
    @pmt_schedule = pmt_schedules(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pmt_schedules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pmt_schedule" do
    assert_difference('PmtSchedule.count') do
      post :create, pmt_schedule: { contract_id: @pmt_schedule.contract_id, pmtAmount: @pmt_schedule.pmtAmount, pmtDate: @pmt_schedule.pmtDate, pmtNumber: @pmt_schedule.pmtNumber }
    end

    assert_redirected_to pmt_schedule_path(assigns(:pmt_schedule))
  end

  test "should show pmt_schedule" do
    get :show, id: @pmt_schedule
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pmt_schedule
    assert_response :success
  end

  test "should update pmt_schedule" do
    patch :update, id: @pmt_schedule, pmt_schedule: { contract_id: @pmt_schedule.contract_id, pmtAmount: @pmt_schedule.pmtAmount, pmtDate: @pmt_schedule.pmtDate, pmtNumber: @pmt_schedule.pmtNumber }
    assert_redirected_to pmt_schedule_path(assigns(:pmt_schedule))
  end

  test "should destroy pmt_schedule" do
    assert_difference('PmtSchedule.count', -1) do
      delete :destroy, id: @pmt_schedule
    end

    assert_redirected_to pmt_schedules_path
  end
end
