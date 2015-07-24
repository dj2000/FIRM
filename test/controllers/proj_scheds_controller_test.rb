require 'test_helper'

class ProjSchedsControllerTest < ActionController::TestCase
  setup do
    @proj_sched = proj_scheds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:proj_scheds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create proj_sched" do
    assert_difference('ProjSched.count') do
      post :create, proj_sched: { crew_id: @proj_sched.crew_id, date: @proj_sched.date, endTime: @proj_sched.endTime, notes: @proj_sched.notes, project_id: @proj_sched.project_id, startTime: @proj_sched.startTime }
    end

    assert_redirected_to proj_sched_path(assigns(:proj_sched))
  end

  test "should show proj_sched" do
    get :show, id: @proj_sched
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @proj_sched
    assert_response :success
  end

  test "should update proj_sched" do
    patch :update, id: @proj_sched, proj_sched: { crew_id: @proj_sched.crew_id, date: @proj_sched.date, endTime: @proj_sched.endTime, notes: @proj_sched.notes, project_id: @proj_sched.project_id, startTime: @proj_sched.startTime }
    assert_redirected_to proj_sched_path(assigns(:proj_sched))
  end

  test "should destroy proj_sched" do
    assert_difference('ProjSched.count', -1) do
      delete :destroy, id: @proj_sched
    end

    assert_redirected_to proj_scheds_path
  end
end
