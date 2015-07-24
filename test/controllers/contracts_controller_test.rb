require 'test_helper'

class ContractsControllerTest < ActionController::TestCase
  setup do
    @contract = contracts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contracts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contract" do
    assert_difference('Contract.count') do
      post :create, contract: { acceptedBy: @contract.acceptedBy, bid_id: @contract.bid_id, date: @contract.date, dateSigned: @contract.dateSigned, downPmtAmt: @contract.downPmtAmt, downPmtDate: @contract.downPmtDate, payPlan_id: @contract.payPlan_id, signedBy: @contract.signedBy }
    end

    assert_redirected_to contract_path(assigns(:contract))
  end

  test "should show contract" do
    get :show, id: @contract
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contract
    assert_response :success
  end

  test "should update contract" do
    patch :update, id: @contract, contract: { acceptedBy: @contract.acceptedBy, bid_id: @contract.bid_id, date: @contract.date, dateSigned: @contract.dateSigned, downPmtAmt: @contract.downPmtAmt, downPmtDate: @contract.downPmtDate, payPlan_id: @contract.payPlan_id, signedBy: @contract.signedBy }
    assert_redirected_to contract_path(assigns(:contract))
  end

  test "should destroy contract" do
    assert_difference('Contract.count', -1) do
      delete :destroy, id: @contract
    end

    assert_redirected_to contracts_path
  end
end
