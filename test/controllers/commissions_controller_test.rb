require 'test_helper'

class CommissionsControllerTest < ActionController::TestCase
  setup do
    @commission = commissions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:commissions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create commission" do
    assert_difference('Commission.count') do
      post :create, commission: { rate: @commission.rate, weekNo: @commission.weekNo, year: @commission.year }
    end

    assert_redirected_to commission_path(assigns(:commission))
  end

  test "should show commission" do
    get :show, id: @commission
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @commission
    assert_response :success
  end

  test "should update commission" do
    patch :update, id: @commission, commission: { rate: @commission.rate, weekNo: @commission.weekNo, year: @commission.year }
    assert_redirected_to commission_path(assigns(:commission))
  end

  test "should destroy commission" do
    assert_difference('Commission.count', -1) do
      delete :destroy, id: @commission
    end

    assert_redirected_to commissions_path
  end
end
