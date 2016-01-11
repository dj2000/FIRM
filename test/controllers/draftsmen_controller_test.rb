require 'test_helper'

class DraftsmenControllerTest < ActionController::TestCase
  setup do
    @draftsman = draftsmen(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:draftsmen)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create draftsman" do
    assert_difference('Draftsman.count') do
      post :create, draftsman: { email: @draftsman.email, first_name: @draftsman.first_name, last_name: @draftsman.last_name, middle_init: @draftsman.middle_init }
    end

    assert_redirected_to draftsman_path(assigns(:draftsman))
  end

  test "should show draftsman" do
    get :show, id: @draftsman
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @draftsman
    assert_response :success
  end

  test "should update draftsman" do
    patch :update, id: @draftsman, draftsman: { email: @draftsman.email, first_name: @draftsman.first_name, last_name: @draftsman.last_name, middle_init: @draftsman.middle_init }
    assert_redirected_to draftsman_path(assigns(:draftsman))
  end

  test "should destroy draftsman" do
    assert_difference('Draftsman.count', -1) do
      delete :destroy, id: @draftsman
    end

    assert_redirected_to draftsmen_path
  end
end
