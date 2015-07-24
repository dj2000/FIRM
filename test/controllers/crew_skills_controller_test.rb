require 'test_helper'

class CrewSkillsControllerTest < ActionController::TestCase
  setup do
    @crew_skill = crew_skills(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:crew_skills)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create crew_skill" do
    assert_difference('CrewSkill.count') do
      post :create, crew_skill: { crew_id: @crew_skill.crew_id, skill_id: @crew_skill.skill_id }
    end

    assert_redirected_to crew_skill_path(assigns(:crew_skill))
  end

  test "should show crew_skill" do
    get :show, id: @crew_skill
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @crew_skill
    assert_response :success
  end

  test "should update crew_skill" do
    patch :update, id: @crew_skill, crew_skill: { crew_id: @crew_skill.crew_id, skill_id: @crew_skill.skill_id }
    assert_redirected_to crew_skill_path(assigns(:crew_skill))
  end

  test "should destroy crew_skill" do
    assert_difference('CrewSkill.count', -1) do
      delete :destroy, id: @crew_skill
    end

    assert_redirected_to crew_skills_path
  end
end
