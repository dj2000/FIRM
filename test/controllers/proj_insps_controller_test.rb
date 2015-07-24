require 'test_helper'

class ProjInspsControllerTest < ActionController::TestCase
  setup do
    @proj_insp = proj_insps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:proj_insps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create proj_insp" do
    assert_difference('ProjInsp.count') do
      post :create, proj_insp: { completeDate: @proj_insp.completeDate, inspectBy: @proj_insp.inspectBy, project_id: @proj_insp.project_id, reference: @proj_insp.reference, result: @proj_insp.result, scheduleDate: @proj_insp.scheduleDate }
    end

    assert_redirected_to proj_insp_path(assigns(:proj_insp))
  end

  test "should show proj_insp" do
    get :show, id: @proj_insp
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @proj_insp
    assert_response :success
  end

  test "should update proj_insp" do
    patch :update, id: @proj_insp, proj_insp: { completeDate: @proj_insp.completeDate, inspectBy: @proj_insp.inspectBy, project_id: @proj_insp.project_id, reference: @proj_insp.reference, result: @proj_insp.result, scheduleDate: @proj_insp.scheduleDate }
    assert_redirected_to proj_insp_path(assigns(:proj_insp))
  end

  test "should destroy proj_insp" do
    assert_difference('ProjInsp.count', -1) do
      delete :destroy, id: @proj_insp
    end

    assert_redirected_to proj_insps_path
  end
end
