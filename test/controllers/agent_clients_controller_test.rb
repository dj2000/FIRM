require 'test_helper'

class AgentClientsControllerTest < ActionController::TestCase
  setup do
    @agent_client = agent_clients(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:agent_clients)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create agent_client" do
    assert_difference('AgentClient.count') do
      post :create, agent_client: { agentDate: @agent_client.agentDate, agent_id: @agent_client.agent_id, client_id: @agent_client.client_id }
    end

    assert_redirected_to agent_client_path(assigns(:agent_client))
  end

  test "should show agent_client" do
    get :show, id: @agent_client
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @agent_client
    assert_response :success
  end

  test "should update agent_client" do
    patch :update, id: @agent_client, agent_client: { agentDate: @agent_client.agentDate, agent_id: @agent_client.agent_id, client_id: @agent_client.client_id }
    assert_redirected_to agent_client_path(assigns(:agent_client))
  end

  test "should destroy agent_client" do
    assert_difference('AgentClient.count', -1) do
      delete :destroy, id: @agent_client
    end

    assert_redirected_to agent_clients_path
  end
end
