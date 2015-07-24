require 'test_helper'

class InspectorsControllerTest < ActionController::TestCase
  setup do
    @inspector = inspectors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inspectors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inspector" do
    assert_difference('Inspector.count') do
      post :create, inspector: { address: @inspector.address, city: @inspector.city, email: @inspector.email, firstName: @inspector.firstName, lastName: @inspector.lastName, middleInit: @inspector.middleInit, phoneC: @inspector.phoneC, phoneH: @inspector.phoneH, senior: @inspector.senior, state: @inspector.state, zip: @inspector.zip }
    end

    assert_redirected_to inspector_path(assigns(:inspector))
  end

  test "should show inspector" do
    get :show, id: @inspector
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inspector
    assert_response :success
  end

  test "should update inspector" do
    patch :update, id: @inspector, inspector: { address: @inspector.address, city: @inspector.city, email: @inspector.email, firstName: @inspector.firstName, lastName: @inspector.lastName, middleInit: @inspector.middleInit, phoneC: @inspector.phoneC, phoneH: @inspector.phoneH, senior: @inspector.senior, state: @inspector.state, zip: @inspector.zip }
    assert_redirected_to inspector_path(assigns(:inspector))
  end

  test "should destroy inspector" do
    assert_difference('Inspector.count', -1) do
      delete :destroy, id: @inspector
    end

    assert_redirected_to inspectors_path
  end
end
