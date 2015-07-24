require 'test_helper'

class InspCommScalesControllerTest < ActionController::TestCase
  setup do
    @insp_comm_scale = insp_comm_scales(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:insp_comm_scales)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create insp_comm_scale" do
    assert_difference('InspCommScale.count') do
      post :create, insp_comm_scale: { inspector_id: @insp_comm_scale.inspector_id, rate: @insp_comm_scale.rate, scaleEnd: @insp_comm_scale.scaleEnd, scaleStart: @insp_comm_scale.scaleStart }
    end

    assert_redirected_to insp_comm_scale_path(assigns(:insp_comm_scale))
  end

  test "should show insp_comm_scale" do
    get :show, id: @insp_comm_scale
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @insp_comm_scale
    assert_response :success
  end

  test "should update insp_comm_scale" do
    patch :update, id: @insp_comm_scale, insp_comm_scale: { inspector_id: @insp_comm_scale.inspector_id, rate: @insp_comm_scale.rate, scaleEnd: @insp_comm_scale.scaleEnd, scaleStart: @insp_comm_scale.scaleStart }
    assert_redirected_to insp_comm_scale_path(assigns(:insp_comm_scale))
  end

  test "should destroy insp_comm_scale" do
    assert_difference('InspCommScale.count', -1) do
      delete :destroy, id: @insp_comm_scale
    end

    assert_redirected_to insp_comm_scales_path
  end
end
