require 'test_helper'

class PropertiesControllerTest < ActionController::TestCase
  setup do
    @property = properties(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:properties)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create property" do
    assert_difference('Property.count') do
      post :create, property: { cdo?: @property.cdo?, city: @property.city, crossStreet: @property.crossStreet, foundation: @property.foundation, gndUnits: @property.gndUnits, hpoz?: @property.hpoz?, lotType: @property.lotType, mapPage: @property.mapPage, number: @property.number, size: @property.size, state: @property.state, stories: @property.stories, street: @property.street, type: @property.type, units: @property.units, yearBuilt: @property.yearBuilt, zip: @property.zip }
    end

    assert_redirected_to property_path(assigns(:property))
  end

  test "should show property" do
    get :show, id: @property
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @property
    assert_response :success
  end

  test "should update property" do
    patch :update, id: @property, property: { cdo?: @property.cdo?, city: @property.city, crossStreet: @property.crossStreet, foundation: @property.foundation, gndUnits: @property.gndUnits, hpoz?: @property.hpoz?, lotType: @property.lotType, mapPage: @property.mapPage, number: @property.number, size: @property.size, state: @property.state, stories: @property.stories, street: @property.street, type: @property.type, units: @property.units, yearBuilt: @property.yearBuilt, zip: @property.zip }
    assert_redirected_to property_path(assigns(:property))
  end

  test "should destroy property" do
    assert_difference('Property.count', -1) do
      delete :destroy, id: @property
    end

    assert_redirected_to properties_path
  end
end
