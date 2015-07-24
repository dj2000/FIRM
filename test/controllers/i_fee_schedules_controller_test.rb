require 'test_helper'

class IFeeSchedulesControllerTest < ActionController::TestCase
  setup do
    @i_fee_schedule = i_fee_schedules(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:i_fee_schedules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create i_fee_schedule" do
    assert_difference('IFeeSchedule.count') do
      post :create, i_fee_schedule: { effectiveFrom: @i_fee_schedule.effectiveFrom, feeActive: @i_fee_schedule.feeActive, insBaseRate: @i_fee_schedule.insBaseRate, insIncRate: @i_fee_schedule.insIncRate, mfrBaseRate: @i_fee_schedule.mfrBaseRate, mfrIncRate: @i_fee_schedule.mfrIncRate, ownerOccRate: @i_fee_schedule.ownerOccRate, sfrBaseRate: @i_fee_schedule.sfrBaseRate, sfrIncRate: @i_fee_schedule.sfrIncRate }
    end

    assert_redirected_to i_fee_schedule_path(assigns(:i_fee_schedule))
  end

  test "should show i_fee_schedule" do
    get :show, id: @i_fee_schedule
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @i_fee_schedule
    assert_response :success
  end

  test "should update i_fee_schedule" do
    patch :update, id: @i_fee_schedule, i_fee_schedule: { effectiveFrom: @i_fee_schedule.effectiveFrom, feeActive: @i_fee_schedule.feeActive, insBaseRate: @i_fee_schedule.insBaseRate, insIncRate: @i_fee_schedule.insIncRate, mfrBaseRate: @i_fee_schedule.mfrBaseRate, mfrIncRate: @i_fee_schedule.mfrIncRate, ownerOccRate: @i_fee_schedule.ownerOccRate, sfrBaseRate: @i_fee_schedule.sfrBaseRate, sfrIncRate: @i_fee_schedule.sfrIncRate }
    assert_redirected_to i_fee_schedule_path(assigns(:i_fee_schedule))
  end

  test "should destroy i_fee_schedule" do
    assert_difference('IFeeSchedule.count', -1) do
      delete :destroy, id: @i_fee_schedule
    end

    assert_redirected_to i_fee_schedules_path
  end
end
