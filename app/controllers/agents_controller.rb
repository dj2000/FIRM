class AgentsController < ApplicationController
  before_action :set_agent, only: [:show, :edit, :update, :destroy]

  # GET /agents
  # GET /agents.json
  def index
    @agents = Agent.all.paginate(page: params[:page])
    respond_to do |format|
      format.html
      format.csv { send_data Agent.as_csv }
    end
  end

  # GET /agents/1
  # GET /agents/1.json
  def show
    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /agents/new
  def new
    @agent = Agent.new
    @agent_client = AgentClient.new
    @remote = request.format.symbol == :html ? false : true
  end

  # GET /agents/1/edit
  def edit
    @remote = false
  end

  # POST /agents
  # POST /agents.json
  def create
    @client = Client.find(params[:client_id]) if params[:client_id].present?
    @remote = request.format.symbol == :html ? false : true
    @agent = Agent.new(agent_params)
    @agent_client = AgentClient.new
    respond_to do |format|
      if @agent.save
        @client.agents << @agent if params[:client_id].present?
        format.html { redirect_to @agent, notice: 'Agent was successfully created.' }
        format.js
      else
        format.html { render :new }
        format.js
      end
    end
  end

  # PATCH/PUT /agents/1
  # PATCH/PUT /agents/1.json
  def update
    respond_to do |format|
      if @agent.update(agent_params)
        format.html { redirect_to @agent, notice: 'Agent was successfully updated.' }
        format.json { render :show, status: :ok, location: @agent }
      else
        format.html { render :edit }
        format.json { render json: @agent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agents/1
  # DELETE /agents/1.json
  def destroy
    @agent.destroy
    respond_to do |format|
      format.html { redirect_to agents_url, notice: 'Agent was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def report
    @agents = Agent.where(created_at: (Date.today..Date.today))
  end

  def print
    @agents = Agent.all
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agent
      @agent = Agent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def agent_params
      params.require(:agent).permit(:firstName, :lastName, :middleInit, :company, :phoneH, :phoneW, :phoneC, :email, :mailAddress)
    end
end
