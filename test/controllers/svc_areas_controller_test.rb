require 'test_helper'

class SvcAreasControllerTest < ActionController::TestCase
  setup do
    @svc_area = svc_areas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:svc_areas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create svc_area" do
    assert_difference('SvcArea.count') do
      post :create, svc_area: { city: @svc_area.city, serviced: @svc_area.serviced, state: @svc_area.state, zip: @svc_area.zip }
    end

    assert_redirected_to svc_area_path(assigns(:svc_area))
  end

  test "should show svc_area" do
    get :show, id: @svc_area
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @svc_area
    assert_response :success
  end

  test "should update svc_area" do
    patch :update, id: @svc_area, svc_area: { city: @svc_area.city, serviced: @svc_area.serviced, state: @svc_area.state, zip: @svc_area.zip }
    assert_redirected_to svc_area_path(assigns(:svc_area))
  end

  test "should destroy svc_area" do
    assert_difference('SvcArea.count', -1) do
      delete :destroy, id: @svc_area
    end

    assert_redirected_to svc_areas_path
  end
end
