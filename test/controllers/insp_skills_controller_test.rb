require 'test_helper'

class InspSkillsControllerTest < ActionController::TestCase
  setup do
    @insp_skill = insp_skills(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:insp_skills)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create insp_skill" do
    assert_difference('InspSkill.count') do
      post :create, insp_skill: { inspector_id: @insp_skill.inspector_id, skill_id: @insp_skill.skill_id }
    end

    assert_redirected_to insp_skill_path(assigns(:insp_skill))
  end

  test "should show insp_skill" do
    get :show, id: @insp_skill
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @insp_skill
    assert_response :success
  end

  test "should update insp_skill" do
    patch :update, id: @insp_skill, insp_skill: { inspector_id: @insp_skill.inspector_id, skill_id: @insp_skill.skill_id }
    assert_redirected_to insp_skill_path(assigns(:insp_skill))
  end

  test "should destroy insp_skill" do
    assert_difference('InspSkill.count', -1) do
      delete :destroy, id: @insp_skill
    end

    assert_redirected_to insp_skills_path
  end
end
