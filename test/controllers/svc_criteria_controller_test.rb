require 'test_helper'

class SvcCriteriaControllerTest < ActionController::TestCase
  setup do
    @svc_criterium = svc_criteria(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:svc_criteria)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create svc_criterium" do
    assert_difference('SvcCriterium.count') do
      post :create, svc_criterium: { cdo: @svc_criterium.cdo, foundation: @svc_criterium.foundation, hpoz: @svc_criterium.hpoz, notes: @svc_criterium.notes, ownerOcc: @svc_criterium.ownerOcc, prevInsp: @svc_criterium.prevInsp, propComm: @svc_criterium.propComm, propRes: @svc_criterium.propRes, yearBuilt: @svc_criterium.yearBuilt }
    end

    assert_redirected_to svc_criterium_path(assigns(:svc_criterium))
  end

  test "should show svc_criterium" do
    get :show, id: @svc_criterium
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @svc_criterium
    assert_response :success
  end

  test "should update svc_criterium" do
    patch :update, id: @svc_criterium, svc_criterium: { cdo: @svc_criterium.cdo, foundation: @svc_criterium.foundation, hpoz: @svc_criterium.hpoz, notes: @svc_criterium.notes, ownerOcc: @svc_criterium.ownerOcc, prevInsp: @svc_criterium.prevInsp, propComm: @svc_criterium.propComm, propRes: @svc_criterium.propRes, yearBuilt: @svc_criterium.yearBuilt }
    assert_redirected_to svc_criterium_path(assigns(:svc_criterium))
  end

  test "should destroy svc_criterium" do
    assert_difference('SvcCriterium.count', -1) do
      delete :destroy, id: @svc_criterium
    end

    assert_redirected_to svc_criteria_path
  end
end
