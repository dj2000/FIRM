require 'test_helper'

class ClientPropertiesControllerTest < ActionController::TestCase
  setup do
    @client_property = client_properties(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:client_properties)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create client_property" do
    assert_difference('ClientProperty.count') do
      post :create, client_property: { clientType: @client_property.clientType, client_id: @client_property.client_id, escrow: @client_property.escrow, escrowDate: @client_property.escrowDate, occupiedBy: @client_property.occupiedBy, property_id: @client_property.property_id, typeDate: @client_property.typeDate }
    end

    assert_redirected_to client_property_path(assigns(:client_property))
  end

  test "should show client_property" do
    get :show, id: @client_property
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @client_property
    assert_response :success
  end

  test "should update client_property" do
    patch :update, id: @client_property, client_property: { clientType: @client_property.clientType, client_id: @client_property.client_id, escrow: @client_property.escrow, escrowDate: @client_property.escrowDate, occupiedBy: @client_property.occupiedBy, property_id: @client_property.property_id, typeDate: @client_property.typeDate }
    assert_redirected_to client_property_path(assigns(:client_property))
  end

  test "should destroy client_property" do
    assert_difference('ClientProperty.count', -1) do
      delete :destroy, id: @client_property
    end

    assert_redirected_to client_properties_path
  end
end
