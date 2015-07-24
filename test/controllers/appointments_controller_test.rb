require 'test_helper'

class AppointmentsControllerTest < ActionController::TestCase
  setup do
    @appointment = appointments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:appointments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create appointment" do
    assert_difference('Appointment.count') do
      post :create, appointment: { allDay: @appointment.allDay, contact: @appointment.contact, inspFee: @appointment.inspFee, inspRequest_id: @appointment.inspRequest_id, inspector_id: @appointment.inspector_id, notes: @appointment.notes, pmtMethod: @appointment.pmtMethod, pmtRef: @appointment.pmtRef, prepaid: @appointment.prepaid, schedEnd: @appointment.schedEnd, schedStart: @appointment.schedStart }
    end

    assert_redirected_to appointment_path(assigns(:appointment))
  end

  test "should show appointment" do
    get :show, id: @appointment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @appointment
    assert_response :success
  end

  test "should update appointment" do
    patch :update, id: @appointment, appointment: { allDay: @appointment.allDay, contact: @appointment.contact, inspFee: @appointment.inspFee, inspRequest_id: @appointment.inspRequest_id, inspector_id: @appointment.inspector_id, notes: @appointment.notes, pmtMethod: @appointment.pmtMethod, pmtRef: @appointment.pmtRef, prepaid: @appointment.prepaid, schedEnd: @appointment.schedEnd, schedStart: @appointment.schedStart }
    assert_redirected_to appointment_path(assigns(:appointment))
  end

  test "should destroy appointment" do
    assert_difference('Appointment.count', -1) do
      delete :destroy, id: @appointment
    end

    assert_redirected_to appointments_path
  end
end
