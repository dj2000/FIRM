class InspRequestsController < ApplicationController
  before_action :set_insp_request, only: [:show, :edit, :update, :destroy]

  def index
    @insp_requests = InspRequest.all
  end

  def show
    if @insp_request.check_conditions_for_appointment
      @appointment = @insp_request.appointment || @insp_request.build_appointment
      @inspectors = Inspector.all.map{|i| [ i.firstName, i.id ]}
      @client_property = ClientProperty.where(property_id: @insp_request.property_id, client_id: @insp_request.client_id).first
      render action: :show
    else
      flash[:notice] = 'Appointment is not allowed.'
      redirect_to insp_requests_path
    end
  end

  def new
    @insp_request = InspRequest.new
    @property = Property.new
    properties_clients_agents
  end

  def edit
    properties_clients_agents
  end

  def create
    @insp_request = InspRequest.new(insp_request_params)
    respond_to do |format|
      if @insp_request.save
        format.html { redirect_to insp_requests_path, notice: 'Inspection request was successfully created.' }
        format.json { render :show, status: :created, location: @insp_request }
      else
        properties_clients_agents
        format.html { render :new }
        format.json { render json: @insp_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @insp_request.update(insp_request_params)
        format.html { redirect_to @insp_request, notice: 'Inspection request was successfully updated.' }
        format.json { render :show, status: :ok, location: @insp_request }
      else
        properties_clients_agents
        format.html { render :edit }
        format.json { render json: @insp_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @insp_request.destroy
    respond_to do |format|
      format.html { redirect_to insp_requests_url, notice: 'Inspection request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_property_clients
    property = Property.find(params[:selector_id])
    @clients = property.clients.map{|c| [c.name, c.id]}
  end

  def get_client_agents
    client = Client.find(params[:selector_id])
    @agents = client.agents.map{|a| [a.name, a.id]}
  end

  def insp_request_info
    @contract = Contract.find_by_id(params[:id])
    @bid = @contract.try(:bid) || Bid.find(params[:id])
    @insp_request = @bid.try(:inspection).try(:appointment).try(:insp_request)
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_insp_request
      @insp_request = InspRequest.find(params[:id])
    end

    def properties_clients_agents
      @properties = Property.all
      @clients = @insp_request.new_record? ? Client.all : (@insp_request.try(:property).try(:clients) || [] )
      @agents = @insp_request.new_record? ? Agent.all : (@insp_request.try(:client).try(:agents) || [] )
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def insp_request_params
      params.require(:insp_request).permit(:callTime, :callerType, :referalSource, :client_id, :agent_id, :property_id, :selectInsp, :occupied_by, :insp_type)
    end
end
