require 'test_helper'

class InspectionsControllerTest < ActionController::TestCase
  setup do
    @inspection = inspections(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inspections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inspection" do
    assert_difference('Inspection.count') do
      post :create, inspection: { businessCards: @inspection.businessCards, fCondition: @inspection.fCondition, footprintURL: @inspection.footprintURL, interiorAccess: @inspection.interiorAccess, nOD: @inspection.nOD, nOG: @inspection.nOG, notes: @inspection.notes, paid?: @inspection.paid?, permit?: @inspection.permit?, repairs?: @inspection.repairs?, reportURL: @inspection.reportURL, verifiedComp: @inspection.verifiedComp, verifiedReport: @inspection.verifiedReport }
    end

    assert_redirected_to inspection_path(assigns(:inspection))
  end

  test "should show inspection" do
    get :show, id: @inspection
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inspection
    assert_response :success
  end

  test "should update inspection" do
    patch :update, id: @inspection, inspection: { businessCards: @inspection.businessCards, fCondition: @inspection.fCondition, footprintURL: @inspection.footprintURL, interiorAccess: @inspection.interiorAccess, nOD: @inspection.nOD, nOG: @inspection.nOG, notes: @inspection.notes, paid?: @inspection.paid?, permit?: @inspection.permit?, repairs?: @inspection.repairs?, reportURL: @inspection.reportURL, verifiedComp: @inspection.verifiedComp, verifiedReport: @inspection.verifiedReport }
    assert_redirected_to inspection_path(assigns(:inspection))
  end

  test "should destroy inspection" do
    assert_difference('Inspection.count', -1) do
      delete :destroy, id: @inspection
    end

    assert_redirected_to inspections_path
  end
end
