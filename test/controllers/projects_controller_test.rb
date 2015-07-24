require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  setup do
    @project = projects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project" do
    assert_difference('Project.count') do
      post :create, project: { authorizedBy: @project.authorizedBy, authorizedOn: @project.authorizedOn, contract_id: @project.contract_id, crew_id: @project.crew_id, estDuration: @project.estDuration, jobCost: @project.jobCost, notes: @project.notes, scheduleBy: @project.scheduleBy, scheduleEnd: @project.scheduleEnd, schedulePref: @project.schedulePref, scheduleStart: @project.scheduleStart, vcDate: @project.vcDate, verifiedAccess: @project.verifiedAccess, verifiedEW: @project.verifiedEW }
    end

    assert_redirected_to project_path(assigns(:project))
  end

  test "should show project" do
    get :show, id: @project
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project
    assert_response :success
  end

  test "should update project" do
    patch :update, id: @project, project: { authorizedBy: @project.authorizedBy, authorizedOn: @project.authorizedOn, contract_id: @project.contract_id, crew_id: @project.crew_id, estDuration: @project.estDuration, jobCost: @project.jobCost, notes: @project.notes, scheduleBy: @project.scheduleBy, scheduleEnd: @project.scheduleEnd, schedulePref: @project.schedulePref, scheduleStart: @project.scheduleStart, vcDate: @project.vcDate, verifiedAccess: @project.verifiedAccess, verifiedEW: @project.verifiedEW }
    assert_redirected_to project_path(assigns(:project))
  end

  test "should destroy project" do
    assert_difference('Project.count', -1) do
      delete :destroy, id: @project
    end

    assert_redirected_to projects_path
  end
end
