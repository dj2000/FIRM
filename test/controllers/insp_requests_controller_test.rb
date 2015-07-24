require 'test_helper'

class InspRequestsControllerTest < ActionController::TestCase
  setup do
    @insp_request = insp_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:insp_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create insp_request" do
    assert_difference('InspRequest.count') do
      post :create, insp_request: { agent_id: @insp_request.agent_id, callTime: @insp_request.callTime, callerType: @insp_request.callerType, client_id: @insp_request.client_id, property_id: @insp_request.property_id, referalSource: @insp_request.referalSource, selectInsp: @insp_request.selectInsp }
    end

    assert_redirected_to insp_request_path(assigns(:insp_request))
  end

  test "should show insp_request" do
    get :show, id: @insp_request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @insp_request
    assert_response :success
  end

  test "should update insp_request" do
    patch :update, id: @insp_request, insp_request: { agent_id: @insp_request.agent_id, callTime: @insp_request.callTime, callerType: @insp_request.callerType, client_id: @insp_request.client_id, property_id: @insp_request.property_id, referalSource: @insp_request.referalSource, selectInsp: @insp_request.selectInsp }
    assert_redirected_to insp_request_path(assigns(:insp_request))
  end

  test "should destroy insp_request" do
    assert_difference('InspRequest.count', -1) do
      delete :destroy, id: @insp_request
    end

    assert_redirected_to insp_requests_path
  end
end
