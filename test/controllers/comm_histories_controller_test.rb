require 'test_helper'

class CommHistoriesControllerTest < ActionController::TestCase
  setup do
    @comm_history = comm_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:comm_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create comm_history" do
    assert_difference('CommHistory.count') do
      post :create, comm_history: { callBackDate: @comm_history.callBackDate, callOutcome: @comm_history.callOutcome, callSummary: @comm_history.callSummary, caller: @comm_history.caller, caller: @comm_history.caller, inspection_id: @comm_history.inspection_id, notes: @comm_history.notes, recipient: @comm_history.recipient }
    end

    assert_redirected_to comm_history_path(assigns(:comm_history))
  end

  test "should show comm_history" do
    get :show, id: @comm_history
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @comm_history
    assert_response :success
  end

  test "should update comm_history" do
    patch :update, id: @comm_history, comm_history: { callBackDate: @comm_history.callBackDate, callOutcome: @comm_history.callOutcome, callSummary: @comm_history.callSummary, caller: @comm_history.caller, caller: @comm_history.caller, inspection_id: @comm_history.inspection_id, notes: @comm_history.notes, recipient: @comm_history.recipient }
    assert_redirected_to comm_history_path(assigns(:comm_history))
  end

  test "should destroy comm_history" do
    assert_difference('CommHistory.count', -1) do
      delete :destroy, id: @comm_history
    end

    assert_redirected_to comm_histories_path
  end
end
