class InspRequestsController < ApplicationController
  before_action :set_insp_request, only: [:show, :edit, :update, :destroy]

  # GET /insp_requests
  # GET /insp_requests.json
  def index
    @insp_requests = InspRequest.all
  end

  # GET /insp_requests/1
  # GET /insp_requests/1.json
  def show
  end

  # GET /insp_requests/new
  def new
    @insp_request = InspRequest.new
  end

  # GET /insp_requests/1/edit
  def edit
  end

  # POST /insp_requests
  # POST /insp_requests.json
  def create
    @insp_request = InspRequest.new(insp_request_params)
    respond_to do |format|
      if @insp_request.save
        format.html { redirect_to insp_requests_path, notice: 'Insp request was successfully created.' }
        format.json { render :show, status: :created, location: @insp_request }
      else
        format.html { render :new }
        format.json { render json: @insp_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /insp_requests/1
  # PATCH/PUT /insp_requests/1.json
  def update
    respond_to do |format|
      if @insp_request.update(insp_request_params)
        format.html { redirect_to @insp_request, notice: 'Insp request was successfully updated.' }
        format.json { render :show, status: :ok, location: @insp_request }
      else
        format.html { render :edit }
        format.json { render json: @insp_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /insp_requests/1
  # DELETE /insp_requests/1.json
  def destroy
    @insp_request.destroy
    respond_to do |format|
      format.html { redirect_to insp_requests_url, notice: 'Insp request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_property_clients
    property = Property.find(params[:selector_id])
    @clients = property.clients
  end

  def get_client_agents

  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_insp_request
      @insp_request = InspRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def insp_request_params
      params.require(:insp_request).permit(:callTime, :callerType, :referalSource, :client_id, :agent_id, :property_id, :selectInsp, :occupied_by, :insp_type)
    end
end
