class AgentClientsController < ApplicationController
  before_action :set_agent_client, only: [:show, :edit, :update, :destroy]

  # GET /agent_clients
  # GET /agent_clients.json
  def index
    @agent_clients = AgentClient.all
  end

  # GET /agent_clients/1
  # GET /agent_clients/1.json
  def show
  end

  # GET /agent_clients/new
  def new
    @agent_client = AgentClient.new
  end

  # GET /agent_clients/1/edit
  def edit
  end

  # POST /agent_clients
  # POST /agent_clients.json
  def create
    @agent_client = AgentClient.new(agent_client_params)

    respond_to do |format|
      if @agent_client.save
        format.html { redirect_to @agent_client, notice: 'Agent client was successfully created.' }
        format.json { render :show, status: :created, location: @agent_client }
      else
        format.html { render :new }
        format.json { render json: @agent_client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /agent_clients/1
  # PATCH/PUT /agent_clients/1.json
  def update
    respond_to do |format|
      if @agent_client.update(agent_client_params)
        format.html { redirect_to @agent_client, notice: 'Agent client was successfully updated.' }
        format.json { render :show, status: :ok, location: @agent_client }
      else
        format.html { render :edit }
        format.json { render json: @agent_client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agent_clients/1
  # DELETE /agent_clients/1.json
  def destroy
    @agent_client.destroy
    respond_to do |format|
      format.html { redirect_to agent_clients_url, notice: 'Agent client was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agent_client
      @agent_client = AgentClient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def agent_client_params
      params.require(:agent_client).permit(:agent_id, :client_id, :agentDate)
    end
end
